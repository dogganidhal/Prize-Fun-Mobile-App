using UnityEngine;

public class Mover : MonoBehaviour
{
    public float speed = 1f;
    public Vector2 direction;

    public void Start()
    {
        direction = direction.normalized;
    }

    public void FixedUpdate()
    {
        transform.position += new Vector3(direction.x, direction.y, 0f) * Time.deltaTime * speed;
    }
}
