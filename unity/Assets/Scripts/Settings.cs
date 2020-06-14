using UnityEngine;

[CreateAssetMenu(fileName = "Settings", menuName = "Settings", order = 1)]
public class Settings : ScriptableObject
{
	[System.Serializable]
	public class Shuttle
	{
		[Header("Base")]
		[Tooltip("Nombre maximum d'astronautes dans la navette")] public int maxHealth = 3;
		[Tooltip("Vitesse verticale d'origine de la navette")] public float verticalBaseSpeed = 0f;
		[Tooltip("Vitesse horizontale d'origine de la navette")] public float horizontalBaseSpeed = 0f;
		[Range(0f, 1f)] public float horitzontalAffectOnVerticalSpeed = 0f;
		[Header("Colors")]
		[Tooltip("Couleur de la navette en mode par defaut")] public Color baseColor;
		[Tooltip("Couleur de la navette en mode 'Golden'")] public Color goldColor;
		[Header("Damage")]
		[Tooltip("Durée de l'invinsibilité après avoir subis un dégat")] public float damageInvulnerabilityDuration = 2f;
		[Tooltip("Taux de ralentissement après avoir subis un dégat")] [Range(0f, 100f)] public float damageSlowPercentage = 50f;
		[Tooltip("Intensité du screenshake après avoir subis un dégat")] public float screenShakeIntensity = 2f;
		[Tooltip("Durée du screenshake après avoir subis un dégat")] public float screenShakeDuration = 3f;
	}
	[System.Serializable]
	public class Boost
	{
		[Tooltip("Durée minimum et maximum du boost")] public Vector2 durationRandomRange;
		[Tooltip("Puissance du boost (2 = vitesse x 2")] public float speedMultiplier = 2f;
		[Tooltip("Plus c'est élévé plus les chances diminue vite (d'optenir la durée maximum")] public float decreasingChanceFactor = 4f;
		[Tooltip("Taux de déformation visuel apporté au spirte pendant le boost")] [Range(0f, 1f)] public float visualsDeformation = 0.2f;
		[Tooltip("Couleur de la navette pendant le boost")] public Color color;
		[Tooltip("Montrer la charge ou non")] public bool showCharge = false;
	}
	[System.Serializable]
	public class Game
	{
		[Header("Chunks")]
		[Tooltip("Décalage horizontal maximal des chunks")] public float horizontalChunkShiftRange = 1f;
		[Tooltip("Augmentation de la vitesse à chaque chunk passé (0.1 = +10%)")] public float verticalSpeedMultiplierByMilestone = 0.1f;
		[Tooltip("Distance entre chaque chunks")] public float distanceBetweenMilestone = 10f;

		[Header("Bonus")]
		[Range(0f, 100f)] public float bonusChance = 25f;
		[Range(0f, 100f)] public float boostChance = 25f;
		[Range(0f, 100f)] public float bombChance = 25f;
		[Range(0f, 100f)] public float shieldChance = 25f;
		[Range(0f, 100f)] public float astronautChance = 25f;
	}
	[System.Serializable]
	public class Texts
	{
		public string disconnetedText = "Disconnected";
		public string highscoreMessageText = "NEW HIGHSCORE!";
		public string quitButtonText = "Quit";
		public string replayButtonText = "Replay";
		[Header("{0} will be replaced by the player score")]
		public string inGameScoreText = "{0}";
		public string requireScoreText = "Score pour gagner {0}";
		public string currentScoreText = "Score {0}";
		public string highScoreText = "Highscore : {0}";
		public string requiredScoreText = "Score à atteindre : {0}";
	}

	public Settings.Shuttle shuttle;
	public Settings.Texts texts;
	public Settings.Boost boost;
	public Settings.Game game;
}
