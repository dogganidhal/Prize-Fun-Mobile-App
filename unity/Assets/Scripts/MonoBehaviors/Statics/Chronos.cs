using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Chronos : MonoBehaviour
{
    public static Chronos i;
    private void Awake()
    {
        if (Chronos.i != null) Destroy(this);
        else
        {
            i = this;
            // DontDestroyOnLoad(gameObject);
        }
    }

    private List<Counter> counters = new List<Counter>();

    void Update()
    {
        foreach(Counter c in counters)
        {
            if(c.activated)
            {
                if (c.ended) counters.Remove(c);
                else c.Tick(Time.deltaTime);
            }
        }
    }

    public Counter Count(float duration = 1f, bool instant = true, Action end = null)
    {
        Counter c = new Counter(duration, instant, end);
        counters.Add(c);
        return c;
    }

    public class Counter
    {
        public float duration = 0f;
        public Action onEnd = null;
        public float timer = 0f;
        public bool activated = false;
        public bool ended = false;
        public float progression = 0f;

        public Counter(float d = 1f, bool instant = true, Action end = null)
        {
            duration = d;
            onEnd = end;
            if (instant) Start();
        }

        public void Start()
        {
            activated = true;
            Reset();
        }

        public void Reset()
        {
            timer = duration;
        }

        public void End()
        {
            if (onEnd != null) onEnd.Invoke();
            activated = false;
            ended = true;
        }

        public void Tick(float deltaTime)
        {
            if(activated)
            {
                progression = timer / duration;
                if (timer > 0) timer -= deltaTime;
                else End();
            }
        }
    }
}
