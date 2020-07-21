using UnityEngine;

public class Pyromancer : MonoBehaviour
{
    public static Pyromancer i;
    private void Awake()
    {
        if (Pyromancer.i != null) Destroy(gameObject);
        else
        {
            i = this;
            // DontDestroyOnLoad(gameObject);
        }
    }

    [System.Serializable]
    public class Effect
    {
        public string name;
        public ParticleSystem particle;
    }

    public Effect[] effects;

    public Effect Get(string name)
    {
        foreach (Effect e in effects) if (e.name == name) return e;
        return null;
    }

    public ParticleSystem Ignite(string name, Vector3 where)
    {
        Effect effect = Get(name);
        if(effect != null)
        {
            ParticleSystem part = effect.particle;
            GameObject o = Instantiate(effect.particle.gameObject, where, Quaternion.identity);
            if (!part.main.loop) Destroy(o, part.main.duration);
            return part;
        }
        return null;
    }
}
