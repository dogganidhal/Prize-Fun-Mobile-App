using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Woofer : MonoBehaviour
{
    public static Woofer i;
    private List<AudioSource> sources = new List<AudioSource>();
    private void Awake()
    {
        if (Woofer.i != null) Destroy(this);
        else
        {
            i = this;
            DontDestroyOnLoad(gameObject);
        }
    }

    [System.Serializable]
    public class Sound
    {
        public string name = "Undefined";
        public AudioClip clip = null;

        [Header("Volume")]
        public float volume = 1f;
        public bool randomVolume = false;
        public Vector2 randomVolumeRange;
        [Header("Pitch")]
        public float pitch = 1f;
        public bool randomPitch = false;
        public Vector2 randomPitchRange;
    }

    public List<Sound> sounds = new List<Sound>();

    public AudioSource Play(string name)
    {
        Sound sound = GetSound(name);
        AudioSource source = GetSource();

        if (sound != null)
        {
            source.volume = sound.volume;
            source.pitch = sound.pitch;
            if (sound.randomVolume) source.volume += Random.Range(sound.randomVolumeRange.x, sound.randomVolumeRange.y);
            if (sound.randomPitch) source.pitch += Random.Range(sound.randomPitchRange.x, sound.randomPitchRange.y);
            source.PlayOneShot(sound.clip);
        }

        return source;
    }

    public Sound GetSound(string name)
    {
        foreach(Sound s in sounds)
        {
            if (s.name == name) return s;
        }
        return null;
    }

    public AudioSource GetSource()
    {
        if(sources.Count > 0)
        {
            foreach (AudioSource src in sources)
            {
                if (!src.isPlaying) return src;
            }
        }

        AudioSource newsrc = gameObject.AddComponent<AudioSource>();
        sources.Add(newsrc);
        return newsrc;
    }
}
