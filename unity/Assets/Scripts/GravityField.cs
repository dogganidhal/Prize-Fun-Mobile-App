using UnityEngine;
public class GravityField : ShuttleTrigger
{
	public float force = 1f;
	public float distance = 1f;

	Transform t;

	public override void ShuttleIn(Shuttle s)
	{
		base.ShuttleIn(s);
		t = s.transform;
	}

	public override void ShuttleOut(Shuttle s)
	{
		base.ShuttleOut(s);
		t = null;
	}

	public void FixedUpdate()
	{
		if(t != null)
		{
			Vector3 dir = transform.position - t.position;
			t.position += dir.normalized * force * (1f - Mathf.Clamp(Mathf.Abs(dir.magnitude) / distance, 0.1f, 1f));
		}
	}
}
