using UnityEngine;

public class Aperture : MonoBehaviour
{
    public static Aperture i;

    void Awake()
    {
        if (Aperture.i != null) Destroy(gameObject);
        else
        {
            i = this;
            DontDestroyOnLoad(gameObject);
        }

        cam = GetComponent<Camera>();
    }

    [System.Serializable]
    public class FloatKey
    {
        public float origin;
        public float target;
        public float current;
        public float offset;
        public float lerp;

        public FloatKey() { }
        public void Reset() { current = origin; }
        public FloatKey(float value)
        {
            origin = value;
            target = value;
            current = value;
        }
    }

    public Transform target;
    public Game.Vector3Key position;
    public Game.Vector3Key rotation;
    public FloatKey distance;
    private Camera cam;

    void FixedUpdate()
    {
        if (target != null) position.target = target.position;
        Calculate();
        Apply();
    }

    void Calculate()
    {
        position.current = Vector3.Lerp(position.current, position.target, position.lerp * Time.deltaTime);
        rotation.current = Vector3.Lerp(rotation.current, rotation.target, rotation.lerp * Time.deltaTime);
        distance.current = Mathf.Lerp(distance.current, distance.target, distance.lerp * Time.deltaTime);
    }

    void Apply()
    {
        if(!cam.orthographic)
        {
            transform.position = position.current + position.offset + Quaternion.Euler(rotation.current + rotation.offset) * Vector3.forward * (distance.current + distance.offset);
            if (target != null) transform.forward = (target.position - transform.position).normalized;
        }
        else
        {
            transform.position = position.current + position.offset - Vector3.forward;
        }
    }

    public void Teleport()
    {
        position.current = position.target;
        rotation.current = rotation.target;
        distance.current = distance.target;
        Apply();
    }
}
