using UnityEngine;
public class StarBoost : ShuttleTrigger
{
	public void Start()
	{
		if (Random.Range(0f, 1f) >= Game.i.settings.game.boostChance / 100f)
		{
			Destroy(gameObject);
		}
	}

	public override void ShuttleIn(Shuttle s)
	{

		float v = 
			Mathf.Pow(Random.value, Game.i.settings.boost.decreasingChanceFactor) 
			* (Game.i.settings.boost.durationRandomRange.y - Game.i.settings.boost.durationRandomRange.x) 
			+ Game.i.settings.boost.durationRandomRange.x;

		s.Boost(v);
		Destroy(gameObject);
	}
}
