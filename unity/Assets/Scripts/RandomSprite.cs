using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomSprite : MonoBehaviour
{

    public Sprite[] sprites;

    void Start()
    {
        if (gameObject.TryGetComponent<SpriteRenderer>(out SpriteRenderer sr))
        {
            sr.sprite = sprites[Random.Range(0, sprites.Length)];
        }
        else Destroy(this);
    }
}
