using System;
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
    public int currentScore = 0;
    public int highScore = 0;
    public bool firstScore = true;

    public List<Player> GetPodium()
    {
        List<Player> p = new List<Player>(players);
        p.Add(new Player("You", highScore));
        p = p.OrderBy(x => -x.score).ToList();
        while(p.Count > 3) p.RemoveAt(p.Count - 1);
        return p;
    }

    public int GetCurrentScore()
    {
        return currentScore;
    }

    public void SetScore(float value)
    {
        currentScore = (int) Math.Truncate(value);
        if (currentScore > highScore)
        {
            highScore = currentScore;
        }
        firstScore = false;
    }

    public void NewScore()
    {
        currentScore = 0;
    }
    
    public int GetHigherScoreValue()
    {
        return highScore;
    }
}
