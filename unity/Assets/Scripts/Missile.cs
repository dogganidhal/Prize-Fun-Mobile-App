using UnityEngine;

public class Missile : MonoBehaviour
{
	public Transform target;
	public float speed = 1f;
	public float rotationLerp = 1f;
	public float treshold = 1f;

	public void FixedUpdate()
	{
		if (target == null)
		{
			Destroy(gameObject);
			return;
		}

		Vector3 pos = new Vector3(target.transform.position.x, target.transform.position.y, transform.position.z);

		transform.up = Vector3.Lerp(
			transform.up,
			(pos - transform.position).normalized,
			Time.deltaTime * rotationLerp
		);
		transform.position += transform.up * speed * Time.deltaTime;

		if(Vector3.Distance(pos, transform.position) <= treshold)
		{
			Pyromancer.i.Ignite("confetti_explosion", target.position);
			Pyromancer.i.Ignite("explosion", target.position);
			ScreenShake.i.Shake(3f, 0.25f);
			Woofer.i.Play("explosion");
			Destroy(target.gameObject);
			Destroy(gameObject);
		}
	}
}
