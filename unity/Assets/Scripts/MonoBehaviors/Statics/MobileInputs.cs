using UnityEngine;
using System;

public class MobileInputs : MonoBehaviour
{
    // STATIC
    public static MobileInputs i;
    private void Awake()
    {
        if (MobileInputs.i != null && MobileInputs.i != this) Destroy(this);
        else
        {
            i = this;
            // DontDestroyOnLoad(gameObject);
        }
    }

    [Header("Settings")]
    [Tooltip("Show debug logs")] public bool log = false;
    [Tooltip("Maximum duration of the swipe to be valid.")] public float swipeMaxDuration = 1f;
    [Tooltip("Minimum length of the swipe to be valid.")] public float swipeMinLength = 500f;

    // SWIPING
    public class SwipeInfo
    {
        public enum Direction { UP, RIGHT, DOWN, LEFT }

        public Vector2 start = new Vector2();
        public Vector2 end = new Vector2();
        public float angle = 0f;
        public float length = 0f;
        public bool started = false;
        public bool ended = false;
        public bool cancelled = false;
        public Direction direction;

        public void Cancel()
        {
            ended = false;
            started = false;
            start = new Vector2();
            end = new Vector2();
            angle = 0f;
            cancelled = true;
        }

        public void Start(Vector2 pos = new Vector2())
        {
            ended = false;
            cancelled = false;
            started = true;
            start = pos;
        }

        public void End(Vector2 pos = new Vector2())
        {
            ended = true;
            started = false;
            end = pos;
            angle = Angle();
            length = Length();

            if(angle >= 315f || angle < 45f) direction = Direction.UP;
            else if(angle >= 45f && angle < 135f) direction = Direction.RIGHT;
            else if(angle >= 135f && angle < 225f) direction = Direction.DOWN;
            else direction = Direction.LEFT;
        }

        public float Angle()
        {
            int dir = 1;
            float offset = 0f;
            if(end.x < start.x) 
            {
                dir = -1;
                offset = 360f;
            }
            return dir * Vector2.Angle(Vector2.up, (end - start).normalized) + offset;
        }

        public float Length()
        {
            return Vector2.Distance(start, end);
        }
    }
    public Action<SwipeInfo> onSwipe;
    public void ClearOnSwipe(){ onSwipe = null; }
    public SwipeInfo swipe = new SwipeInfo();

    // TAPPING
    public Action<Vector2> onTap;
    public void ClearOnTap(){ onTap = null; }
    [HideInInspector] public Vector2 tapPosition = new Vector2();
    [HideInInspector] public bool tapDown = false;
    [HideInInspector] public bool tapHold = false;
    [HideInInspector] public bool tapUp = false;

    float swipeTimer = 0f;

    public void Update()
    {
        DefaultCatcher();
        /*
        if (Application.isEditor) DefaultCatcher();
        else
        {
#if UNITY_EDITOR || UNITY_WEBGL
            DefaultCatcher();
#endif
#if UNITY_ANDROID || UNITY_IOS
            MobileCatcher();
#endif
        }

    */




        if (swipe.started)
        {
            if(swipeTimer > 0) swipeTimer -= Time.deltaTime;
            else 
            {
                swipe.Cancel();

                if(log) Debug.Log("Swipe took too long, cancelled.");
            }
        }
    }

    private void DefaultCatcher()
    {
        if (Input.GetMouseButtonDown(0)) Down(Input.mousePosition);
        else if (Input.GetMouseButtonUp(0)) Up(Input.mousePosition);
        else
        {
            tapDown = false;
            tapUp = false;
        }
        tapHold = Input.GetMouseButton(0);
        tapPosition = Input.mousePosition;
    }

    private void MobileCatcher()
    {
        if (Input.touchCount > 0)
        {
            tapPosition = Input.touches[0].position;
            TouchPhase phase = Input.touches[0].phase;
            if (phase == TouchPhase.Began) Down(Input.touches[0].position);
            if (phase == TouchPhase.Ended) Up(Input.touches[0].position);
            else
            {
                tapDown = false;
                tapUp = false;
                tapHold = true;
            }
        }
        //else tapPosition = new Vector2();
    }

    private void Down(Vector2 pos = new Vector2())
    {
        tapDown = true;
        tapUp = false;

        swipe.Start(pos);
        swipeTimer = swipeMaxDuration;

        if(onTap != null) onTap.Invoke(pos);
        if(log) Debug.Log("Tap detected! Position " + pos);
    }

    private void Up(Vector2 pos = new Vector2())
    {
        tapDown = false;
        tapUp = true;

        swipe.End(pos);
        if(!swipe.cancelled && swipe.length >= swipeMinLength) 
        {
            if(onSwipe != null) onSwipe.Invoke(swipe);
            if(log) Debug.Log("Swipe detected! Direction " + swipe.direction);
        }
    }
}
