using UnityEngine;

public class MobileJoystick : MonoBehaviour
{
    public static MobileJoystick i;
    private void Awake() { i = this; }

    [Header("Settings")]
    public float radius = 5f;
    public float followLerpSpeed = 1f;
    public bool followFinger = true;
    public bool resetOnRelease = true;

    [Header("Inputs (ReadOnly)")]
    // Access only the direction via this variable
    public Vector2 direction;

    [Header("Joystick System (ReadOnly)")]
    public Vector2 startPosition;
    public Vector2 currentPosition;
    public bool activated = false;

    void Update()
    {
        // Check if the Joystick should spawn or get destroyed
        if(IsFingerDown())
        {
            if(Application.isEditor) SpawnJoystick(Input.mousePosition);
            else SpawnJoystick(Input.touches[0].position);
        }
        else if(IsFingerUp()) DestroyJoystick();


        // If the joystick is behing used
        if(activated)
        {
            // Get the current position of the finger/Cursor and save it
            currentPosition = GetFingerPosition();

            // Get the direction input depending of the center and the currentPosition
            direction = GetDirectionInput(startPosition, currentPosition);

            // if the direction magnitude exceed 1, it means the joystick must follow the currentPosition
            if(followFinger && direction.magnitude > 1)
            {
                startPosition += (currentPosition - startPosition) * Time.deltaTime * followLerpSpeed;
            }

            // Clamp the vector in a 1 scale space
            direction = Vector2.ClampMagnitude(direction, 1f);
        }
    }

    private bool IsFingerUp() // Check if user has released the screen 
    {
        if(Application.isEditor)
        {
            if(Input.GetMouseButtonUp(0)) return true;
        }
        else
        {
            if(Input.touches.Length > 0)
            {
                if(Input.touches[0].phase == TouchPhase.Ended) return true;
            }
        }

        return false;
    }

    private bool IsFingerDown() // Detect if the user has touched the screen 
    {
        if(Application.isEditor)
        {
            if(Input.GetMouseButtonDown(0)) return true;
        }
        else
        {
            if(Input.touches.Length > 0)
            {
                if(Input.touches[0].phase == TouchPhase.Began) return true;
            }
        }

        return false;
    }

    private void SpawnJoystick(Vector2 position) // Initialize the joystick at the wanted position 
    {
        startPosition = position;
        activated = true;
    }

    private void DestroyJoystick() // End the joystick 
    {
        activated = false;
        currentPosition = startPosition;
        if(resetOnRelease) direction = new Vector2();
    }

    private Vector2 GetFingerPosition() // Get the position of the cursor/finger depending on the environment 
    {
        if(Application.isEditor) return Input.mousePosition;
        else return Input.touches[0].position;
    }

    private Vector2 GetDirectionInput(Vector2 center, Vector2 current) // Get the vector direction of the virtual joystick 
    {
        // Create empty vector2
        Vector2 dir = new Vector2();
        dir = -(center - current) / radius;
        return dir; 
    }

    void OnEnable()
    {
        Reset();
    }
    void OnDisable()
    {
        Reset();
    }

    void Reset()
    {
        direction = new Vector2();
        startPosition = new Vector2();
        currentPosition = new Vector2();
        activated = false;
    }
}
