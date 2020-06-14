using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class GameData : MonoBehaviour
{
    [System.Serializable]
    public class Player
    {
        public string username;
        public float score;

        public Player(string u, float s)
        {
            username = u;
            score = s;
        }
    }
    public List<Player> players = new List<Player>();
    public int currentScore = -1;
    public List<float> scores = new List<float>();

    public List<Player> GetPodium()
    {
        List<Player> p = new List<Player>(players);
        p.Add(new Player("You", GetHigherScoreIndex() > -1 ? GetHigherScoreValue() : 0f));
        p = p.OrderBy(x => -x.score).ToList();
        while(p.Count > 3) p.RemoveAt(p.Count - 1);
        return p;
    }

    public float GetCurrentScore()
    {
        return scores[currentScore];
    }

    public void SetScore(float value)
    {
        if (currentScore >= 0 && currentScore < scores.Count)
            scores[currentScore] = value;
    }

    public void NewScore()
    {
        scores.Add(0f);
        currentScore = scores.Count - 1;
    }

    public int GetHigherScoreIndex()
    {
        float hValue = 0f;
        int hIndex = -1;
        for (int i = 0; i < scores.Count; i++)
        {
            if (scores[i] > hValue)
            {
                hValue = scores[i];
                hIndex = i;
            }
        }
        return hIndex;
    }

    public float GetHigherScoreValue()
    {
        float hValue = 0f;
        for (int i = 0; i < scores.Count; i++)
        {
            if (scores[i] > hValue) hValue = scores[i];
        }
        return hValue;
    }
}
