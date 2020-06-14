using UnityEngine;
public class Shield : ShuttleTrigger
{
	public void Start()
	{
		if (Random.Range(0f, 1f) >= Game.i.settings.game.shieldChance / 100f)
		{
			Destroy(gameObject);
		}
	}

	public override void ShuttleIn(Shuttle s)
	{
		if (!s.shielded)
		{
			s.GainShield();
			Destroy(gameObject);
		}
	}
}
