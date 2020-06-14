using UnityEngine;
using System.Collections.Generic;

public class BonusSpawner : MonoBehaviour
{
	public void Start()
	{
		Random.InitState(System.DateTime.Now.Millisecond);
		if (Random.Range(0f, 1f) <= Game.i.settings.game.bonusChance / 100f)
		{
			switch (Random.Range(0, 4))
			{

				case 0:
					Random.InitState(System.DateTime.Now.Millisecond);
					if (Random.Range(0f, 1f) <= Game.i.settings.game.astronautChance / 100f)
						Spawn(Library.i.astronautPrefab);
					break;
				case 1:
					Random.InitState(System.DateTime.Now.Millisecond);
					if (Random.Range(0f, 1f) <= Game.i.settings.game.boostChance / 100f)
						Spawn(Library.i.boostPrefab);
					break;
				case 2:
					Random.InitState(System.DateTime.Now.Millisecond);
					if (Random.Range(0f, 1f) <= Game.i.settings.game.bombChance / 100f)
						Spawn(Library.i.bombPrefab);
					break;
				case 3:
					Random.InitState(System.DateTime.Now.Millisecond);
					if (Random.Range(0f, 1f) <= Game.i.settings.game.shieldChance / 100f)
						Spawn(Library.i.shieldPrefab);
					break;
			}
		}

		Destroy(gameObject);
	}

	public void Spawn(GameObject o)
	{
		Instantiate(o, transform.position, Quaternion.identity);
		Destroy(gameObject);
	}
}
