using UnityEngine;
public class Bomb : ShuttleTrigger
{
	public void Start()
	{
		if(Random.Range(0f, 1f) >= Game.i.settings.game.bombChance / 100f)
		{
			Destroy(gameObject);
		}
	}

	public override void ShuttleIn(Shuttle s)
	{
		foreach(Obstacle o in FindObjectsOfType<Obstacle>())
		{
			Missile m = Instantiate(Library.i.missilePrefab, transform.position, Quaternion.identity)
			.GetComponent<Missile>();
			m.transform.up = new Vector3(Random.Range(-1f, 1f), Random.Range(0.2f, 1f), 0f);
			m.target = o.transform;
		}

		Woofer.i.Play("bomb_activated");
		Destroy(gameObject);
	}
}
