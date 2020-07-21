using System;
using System.Collections.Generic;
using FlutterUnityPlugin;
using UnityEngine;
using UnityEngine.SceneManagement;
using Random = UnityEngine.Random;

public class Game : MonoBehaviour
{
    public static Game i;
    private void Awake()
    {
        SendFlutterMessage("lifecycle", "event", "awake");
        if (Game.i != null) Destroy(gameObject);
        else
        {
            i = this;
            // DontDestroyOnLoad(gameObject);
        }
    }

    // DATA TO UPDATE WHEN THE GAME IS LOADED
    public float requiredScore = 100f;
    public bool connectedToInternet = true;

    public GameData data;
    public Settings settings;

    private Shuttle player;
    private float milestoneHeight = 0f;
    private int milestoneCount = 0;
    [HideInInspector] public bool generateChunks = true;
    private List<GameObject> chunks = new List<GameObject>();
    public ParticleSystem stars;
    private static int _UnityViewId = 0;

    [System.Serializable]
    public class Vector3Key
    {
        public Vector3 origin;
        public Vector3 target;
        public Vector3 current;
        public Vector3 offset;
        public float lerp;

        public Vector3Key() { }
        public void Reset() { current = origin; }
        public Vector3Key(Vector3 value)
        {
            origin = value;
            target = value;
            current = value;
        }
    }

    public void Start()
    {
        SendFlutterMessage("lifecycle", "event", "start");
        HUD.i.restart.onClick.AddListener(Load);
        HUD.i.restartText.text = settings.texts.replayButtonText;
        HUD.i.quit.onClick.AddListener(() =>
        {
            SendFlutterMessage("post_score", "score", $"{data.GetHigherScoreValue():0}");
            SceneManager.LoadScene(SceneManager.GetActiveScene().name);
            _UnityViewId++;
            // Destroy(data);
            // Destroy(Camera.current);
        });
        HUD.i.quitText.text = settings.texts.quitButtonText;
        Load();
    }

    public void SetTargetScore(string message)
    {
        requiredScore = float.Parse((Messages.Receive(message).data));
    }

    public void Update()
    {
        if (player != null)
        {
            data.SetScore(player.transform.position.y);
            HUD.i.distance.text = string.Format(settings.texts.inGameScoreText, data.GetCurrentScore().ToString("0"));
            if (player.transform.position.y >= milestoneHeight) ReachMilestone();
            if (data.GetCurrentScore() >= requiredScore && !player.golden) player.Golden();
            if (player.on) Aperture.i.position.target = new Vector3(0f, player.transform.position.y, 0f);
        }
    }

    public void ReachMilestone()
    {
        SendFlutterMessage("lifecycle", "event", "reach_milestone");
        milestoneHeight += Game.i.settings.game.distanceBetweenMilestone;
        SpawnChunk();
        player.DivideSpeed(1f + Game.i.settings.game.verticalSpeedMultiplierByMilestone * (milestoneCount + 1));
        milestoneCount++;
        player.MultiplySpeed(1f + Game.i.settings.game.verticalSpeedMultiplierByMilestone * (milestoneCount + 1));
    }

    public void SpawnChunk()
    {
        SendFlutterMessage("lifecycle", "event", "spawn_chunk");
        if (generateChunks)
        {
            Random.InitState(System.DateTime.Now.Millisecond);
            float shift = Random.Range(-settings.game.horizontalChunkShiftRange, settings.game.horizontalChunkShiftRange);
            chunks.Add(
                Instantiate(Library.i.GetChunk(),
                new Vector3(shift, milestoneHeight, 10f),
                Quaternion.identity)
            );
        }

        if (chunks.Count >= 3)
        {
            Destroy(chunks[0]);
            chunks.RemoveAt(0);
        }
    }

    public void ClearChunks()
    {
        foreach (GameObject go in chunks) Destroy(go);
        foreach (Astronaut a in FindObjectsOfType<Astronaut>()) Destroy(a.gameObject);
        chunks.Clear();
    }

    public void Load()
    {
        SendFlutterMessage("lifecycle", "event", "load");
        milestoneHeight = 0f;
        data.NewScore();
        ClearChunks();
        Spawn();
        ReachMilestone();
        stars.Clear();
        HUD.i.end.gameObject.SetActive(false);
        HUD.i.distance.gameObject.SetActive(true);
    }
    
    public void Loose()
    {
        SendFlutterMessage("lifecycle", "event", "loose");
        HUD.i.requiredScore.text = string.Format(settings.texts.requireScoreText, requiredScore.ToString("0"));
        if(data.GetHigherScoreValue() > requiredScore) requiredScore = data.GetHigherScoreValue();
        
        // Affichage de NEW HIGHSCORE
        if (data.currentScore == data.GetHigherScoreIndex()) HUD.i.newhighscore.gameObject.SetActive(true);
        else HUD.i.newhighscore.gameObject.SetActive(false);

        Aperture.i.target = null;
        HUD.i.distance.gameObject.SetActive(false);
        HUD.i.end.gameObject.SetActive(true);
        HUD.i.score.text = string.Format(settings.texts.currentScoreText, data.GetCurrentScore().ToString("0"));
        HUD.i.highscore.text = string.Format(settings.texts.highScoreText, data.GetHigherScoreValue().ToString("0"));

        // Affichage de la connectivité ou non
        if (!connectedToInternet)
        {
            HUD.i.disconnectedText.text = settings.texts.disconnetedText;
            HUD.i.disconnectedHolder.SetActive(true);
        }
        else
        {
            HUD.i.disconnectedHolder.SetActive(false);
        }

        // player = null;
        Woofer.i.Play("game_over");
    }

    public void Spawn()
    {
        SendFlutterMessage("lifecycle", "event", "spawn");
        if (player != null) Destroy(player.gameObject);
        player = Instantiate(Library.i.shuttlePrefab, new Vector3(), Quaternion.identity).GetComponent<Shuttle>();
        player.Freeze();

        if(data.scores.Count > 1) player.StartWithoutAnimation();
        else player.StartWithAnimation();

        Aperture.i.position.offset = new Vector3(0f, 2f, -100f);
        Aperture.i.position.target = new Vector3(0f, player.transform.position.y, 0f);
        Aperture.i.Teleport();
    }

    public Vector2 View()
    {
        float height = Camera.main.orthographicSize * 2.0f;
        float width = height * Camera.main.aspect;
        return new Vector2(width, height);
    }

    private static void SendFlutterMessage(string type, string payloadKey, string payload)
    {
        Messages.Send(new Message
        {
            id = _UnityViewId,
            data = "{" + $"\"_type\": \"{type}\", \"{payloadKey}\": \"{payload}\"}}"
        });
    }
}
