using System;
using UnityEngine;

public class SizeAnimation : MonoBehaviour
{
    // HOW TO USE
    // Drag this component to any UI or GameObject to add a simple to tweak
    // size pulse animation, simple setup a curve + duration and the object
    // will resize by following the settings
    
    [Header("Settings")]
    public AnimationCurve curve;
    public float duration = 1f;
    public bool loop = true;
    public bool playOnAwake = true;
    public event System.Action onAnimationEnd;

    private bool playing = false;
    public bool IsPlaying(){return playing;}

    private Vector3 initialSize;
    private float timer = 0f;

    void Awake()
    {
        initialSize = transform.localScale;
        if(playOnAwake) Play();
    }
    void Enable()
    {
        if(playOnAwake) Play();
    }

    public void Update()
    {
        if(!playing) return;

        if(timer <= duration)
        {
            timer += Time.deltaTime;
            transform.localScale = initialSize * curve.Evaluate(timer/duration);
        }
        else
        {
            // Animation End
            playing = false;
            if(onAnimationEnd != null) onAnimationEnd.Invoke();
            if(loop) 
            {
                Restart();
                Play();
            }
            else transform.localScale = initialSize;
        }
    }
    public void Play(bool restart = false)
    {
        playing = true;
        if(restart) Restart();
    }
    public void Pause(){playing = false;}
    public void Restart(){timer = 0f;}

    public void Stop()
    {
        Pause();
        Restart();
        transform.localScale = initialSize;
    }

    public void Clean()
    {
        onAnimationEnd = null;
    }
}
