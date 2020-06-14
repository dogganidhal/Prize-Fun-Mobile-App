using UnityEngine;

public class Spliter : MonoBehaviour
{
    [Header("References")]
    public Transform t1;
    public Transform t2;

    [Header("Settings")]
    public float minDistance = 0f;
    public float maxDistance = 0f;
    public float minHeight = -2f;
    public float maxHeight = 2f;
    public float minSize = 0.5f;
    public float maxSize = 2f;

    void Start()
    {
        if(t1 == null || t2 == null) Destroy(this);

        t1.SetParent(transform);
        t2.SetParent(transform);

        Random.InitState(System.DateTime.Now.Millisecond);
        float d = Random.Range(minDistance, maxDistance);
        Random.InitState(System.DateTime.Now.Millisecond);
        float h = Random.Range(minHeight, maxHeight);
        Random.InitState(System.DateTime.Now.Millisecond);
        float r1 = Random.Range(minSize, maxSize);
        Random.InitState(System.DateTime.Now.Millisecond);
        float r2 = Random.Range(minSize, maxSize);

        t1.transform.localPosition = new Vector3(-d, h, 0f);
        t2.transform.localPosition = new Vector3(d, h, 0f);
        t1.transform.localScale = Vector3.one * r1;
        t2.transform.localScale = Vector3.one * r2;
    }
}
