using UnityEngine;
public class Astronaut : ShuttleTrigger
{
	public enum State { ONBOARD, FLOATING, DROPPED, WALKING, IDLE }

	[Header("References")]
	public SpriteRenderer bubble;
	public SpriteRenderer head;
	public SpriteRenderer[] body;
	public Animation anim;
	[Header("Settings")]
	public float walkSpeed = 1f;
	public float floatingRotationSpeed = 35f;
	public float droppedRotationSpeed = 250f;
	public System.Action arrived;
	[HideInInspector] public bool generated = true;
	[HideInInspector] public Astronaut.State state;
	[HideInInspector] public Shuttle shuttle;
	private Vector2 dir;
	private Vector2 target;

	public override void Awake()
	{
		base.Awake();
		EnterState(State.FLOATING);
	}

	public void Start()
	{
		if(generated)
		{
			if (Random.Range(0f, 1f) >= Game.i.settings.game.astronautChance / 100f)
			{
				Destroy(gameObject);
			}
		}
	}

	public void EnterState(Astronaut.State s)
	{
		ExitState(state);
		state = s;
		switch(state)
		{
			case State.ONBOARD:
				bubble.enabled = false;
				anim.Play("A_Astro_Idle");
				foreach (SpriteRenderer sr in body)
				{
					sr.gameObject.SetActive(false);
				}
				head.transform.localScale = new Vector3(0.075f, 0.075f, 1f);
				head.sprite = Library.i.expressions[0];
				break;
			case State.FLOATING:
				bubble.enabled = true;
				anim.Play("A_Astro_Flying");
				head.sprite = Library.i.expressions[1];
				break;
			case State.DROPPED:
				anim.Play("A_Astro_Flying");
				bubble.enabled = true;
				shuttle = null;
				Woofer.i.Play("falling");
				dir = new Vector2(Random.Range(-1f, 1f), Random.Range(0f, -1f));
				head.sprite = Library.i.expressions[2];
				break;
			case State.WALKING:
				anim.Play("A_Astro_Walking");
				head.sprite = Library.i.expressions[3];
				break;
			case State.IDLE:
				anim.Play("A_Astro_Idle");
				head.sprite = Library.i.expressions[0];
				break;
		}
	}
	public void ExitState(Astronaut.State s)
	{
		switch (state)
		{
			case State.ONBOARD:
				foreach (SpriteRenderer sr in body)
				{
					sr.gameObject.SetActive(true);
				}
				head.transform.localScale = new Vector3(0.05f, 0.05f, 1f);
				break;
			case State.FLOATING:
				break;
			case State.DROPPED:
				break;
		}
	}
	public void UpdateState(Astronaut.State s)
	{
		switch (state)
		{
			case State.ONBOARD:
				break;
			case State.FLOATING:
				break;
			case State.DROPPED:
				break;
		}
	}
	public void FixedUpdateState(Astronaut.State s)
	{
		switch (state)
		{
			case State.WALKING:
				Vector3 t = new Vector3(target.x, target.y, transform.position.z);
				Vector3 d = (t - transform.position).normalized;
				transform.right = d;
				transform.position += d * Time.deltaTime * walkSpeed;

				if(Vector2.Distance(t, new Vector2(transform.position.x, transform.position.y)) < 0.2f)
				{
					EnterState(State.IDLE);
					if (arrived != null) arrived.Invoke();
				}
				break;
			case State.FLOATING:
				transform.Rotate(Vector3.forward * Time.deltaTime * floatingRotationSpeed);
				break;
			case State.DROPPED:
				transform.Rotate(Vector3.forward * Time.deltaTime * droppedRotationSpeed);
				transform.position += new Vector3(dir.x, dir.y, 0f) * Time.deltaTime * 1f;
				break;
		}
	}

	public void Board(Shuttle s)
	{
		transform.SetParent(null);
		shuttle = s;
		EnterState(State.ONBOARD);
	}

	public void Update()
	{
		UpdateState(state);
	}
	public void FixedUpdate()
	{
		FixedUpdateState(state);
	}

	public void Walk(Vector2 pos, System.Action arrived = null)
	{
		EnterState(State.WALKING);
		target = pos;
		if (arrived != null) this.arrived += arrived;
	}

	public void Die()
	{
		EnterState(State.DROPPED);
	}

	public override void ShuttleIn(Shuttle s)
	{
		if (!s.IsFull() && s.on  && state == State.FLOATING)
		{
			s.Heal();
			s.Board(this);
			EnterState(State.ONBOARD);
			shuttle = s;
		}
	}
}
