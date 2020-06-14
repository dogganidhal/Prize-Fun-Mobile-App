using UnityEngine;
using System.Collections.Generic;

public class Library : MonoBehaviour
{
    public static Library i;
    private void Awake()
    {
        if (Library.i != null) Destroy(this);
        else
        {
            i = this;
            DontDestroyOnLoad(gameObject);
        }
    }

    [Header("Prefabs")]
    public GameObject shuttlePrefab;
    public GameObject planetPrefab;
    public GameObject scoreMarkerPrefab;
    public GameObject missilePrefab;

    public GameObject astronautPrefab;
    public GameObject boostPrefab;
    public GameObject bombPrefab;
    public GameObject shieldPrefab;

    [Header("Materials")]
    public Material defaultTrail;
    public Material rainbowTrail;
    public Material goldenTrail;

    [Header("Prefabs")]
    public GameObject[] chunks;

    [Header("Strings")]
    public string[] podiumText;

    [Header("Colors")]
    public Color[] podiumColor;

    [Header("Sprites")]
    public Sprite[] expressions;
    public Sprite goldSprite;
    public Sprite baseSprite;

    public GameObject GetChunk()
    {
        Random.InitState(System.DateTime.Now.Millisecond);
        return chunks[Random.Range(0, chunks.Length)];
    }
}
