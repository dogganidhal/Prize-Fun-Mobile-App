using UnityEngine;

public class ScreenShake : MonoBehaviour
{
    // SINGLETON
    public static ScreenShake i;
    void Awake(){i = this;}

    // SYSTEM
    private float timer = 0f;
    private float intensity = 0f;
    private float ratio = 0f;
    private float duration = 0f;
    private Vector3 shakeOffset;

    [Header("Settings")]
    public bool right;
    public bool up;
    public bool forward;

    public void Shake(float intensity = 0.5f, float duration = 1f) // Trigger a shake effect with Intensity and duration setting
    {   
        this.intensity = intensity;
        this.duration = intensity;
        timer = duration;
    }

    public void Update()
    {
        if(timer > 0)
        {
            timer -= Time.deltaTime;
            ratio = timer/duration;

            Vector3 rand = Random.insideUnitSphere;
            rand = new Vector3(
                rand.x * (right ? 1f : 0f),
                rand.y * (up ? 1f : 0f),
                rand.z * (forward ? 1f : 0f)
            );

            shakeOffset = rand * intensity * ratio;
            Aperture.i.transform.position += shakeOffset;
        }
    }
}