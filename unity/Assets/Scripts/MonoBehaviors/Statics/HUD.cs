using UnityEngine;
using System.Collections.Generic;
using TMPro;
using UnityEngine.UI;

public class HUD : MonoBehaviour
{
    public static HUD i;

    private void Awake()
    {
        if (HUD.i != null) Destroy(gameObject);
        else
        {
            i = this;
            // DontDestroyOnLoad(gameObject);
        }
    }

    [Header("InGame")]
    public TMP_Text distance;
    public Slider chargeSlider;
    public RectTransform chargeRT;
    [Header("End")]
    public GameObject disconnectedHolder;
    public TMP_Text disconnectedText;
    public GameObject end;
    public GameObject newhighscore;
    public TMP_Text requiredScore;
    public TMP_Text score;
    public TMP_Text highscore;

    public Button restart;
    public TMP_Text restartText;
    public Button quit;
    public TMP_Text quitText;

    public RectTransform leaderboardRT;
    public GameObject playerScoreTextPrefab;

    public void RefreshLeaderboard()
    {
        foreach (Transform child in leaderboardRT) Destroy(child.gameObject);
        List<GameData.Player> p = Game.i.data.GetPodium();

        for (int i = 0; i < p.Count; i++)
        {
            TMP_Text t = Instantiate(playerScoreTextPrefab, leaderboardRT).GetComponent<TMP_Text>();
            t.text = string.Format(
                Library.i.podiumText[i],
                p[i].username,
                ColorUtility.ToHtmlStringRGB(Library.i.podiumColor[i]),
                p[i].score.ToString("0")
            );
        }
    }

    public void ShowCharge(float value, Vector3 position)
    {
        chargeRT.gameObject.SetActive(true);
        Vector2 pos = Camera.main.WorldToScreenPoint(position);
        value = Mathf.Clamp(value, 0f, 1f);
        chargeRT.position = pos + new Vector2(-150f, 0f);
        chargeSlider.value = value;
    }
    public void HideCharge()
    {
        chargeRT.gameObject.SetActive(false);
    }
}
