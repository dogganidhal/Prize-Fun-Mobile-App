using UnityEngine;
using System.Collections.Generic;

public class Orbiter : MonoBehaviour
{
    public List<Transform> elements = new List<Transform>();
    public float radius;
    public float speed;

    void Update()
    {
        for(int i = 0; i < elements.Count; i++)
        {
            if (elements[i] == null)
            {
                elements.RemoveAt(i);
                break;
            }

            float angle = ((float)i / (float)elements.Count) * Mathf.PI * 2;
            Vector3 pos =  new Vector3(Mathf.Cos(Time.time * speed + angle) * radius, Mathf.Sin(Time.time * speed + angle) * radius, 0f);
            elements[i].localPosition = pos;
        }
    }
}
