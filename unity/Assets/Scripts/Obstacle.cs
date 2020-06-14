using UnityEngine;
public class Obstacle : ShuttleTrigger
{
	[Header("Settings")]
	public int damage = 1;
	public bool canRehitShuttle = false;
	public bool destroyOnHit = false;
	Shuttle hitShuttle = null;

	public override void ShuttleIn(Shuttle s)
	{
		if (!s.IsInvicible() && s.on)
		{
			if (canRehitShuttle) s.Damage(damage);
			else if (hitShuttle != s) s.Damage(damage);
		}
		if (destroyOnHit)
		{
			Woofer.i.Play("explosion");
			Pyromancer.i.Ignite("explosion", transform.position);
			Destroy(gameObject);
		}
	}
}
