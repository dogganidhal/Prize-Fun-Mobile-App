using UnityEngine;

public class ShuttleTrigger : MonoBehaviour
{
	internal Collider2D col;

	public virtual void Awake()
	{
		col = GetComponent<Collider2D>();
		if (col != null) col.isTrigger = true;
	}

	public void OnTriggerEnter2D(Collider2D other)
	{
		if (other.gameObject.TryGetComponent<Shuttle>(out Shuttle s))
		{
			ShuttleIn(s);
		}
	}

	public void OnTriggerExit2D(Collider2D other)
	{
		if (other.gameObject.TryGetComponent<Shuttle>(out Shuttle s))
		{
			ShuttleOut(s);
		}
	}

	public virtual void ShuttleIn(Shuttle s){}
	public virtual void ShuttleOut(Shuttle s){}
}

