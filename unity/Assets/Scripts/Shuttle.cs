using UnityEngine;
using System.Collections.Generic;

public class Shuttle : MonoBehaviour
{
	[Header("References")]
	public Rigidbody2D rb;
	public Transform visuals;
	public TrailRenderer trail;
	public ParticleSystem starPS;
	public SpriteRenderer bubble;
	public SpriteRenderer front;
	public Animation anim;
	public Transform shieldTransform;

	[Header("Passenger")]
	public Vector2 offset;
	public float distanceBetween = 0.25f;
	public float rotationLerp = 10f;
	public float positionLerp = 25f;

	[HideInInspector] public bool shielded;
	private float vSpeed = 1f;
	private float hSpeed = 1f;
	private float hLerp = 5f;
	private int health = 0;
	private float direction = 0f;
	private float horizontal = 0f;
	[HideInInspector] public bool golden = false;
	[HideInInspector] public bool on;

	public void Start()
	{
		Heal();
		ResetVisual();
		vSpeed = Game.i.settings.shuttle.verticalBaseSpeed;
		hSpeed = Game.i.settings.shuttle.horizontalBaseSpeed;
	}

	public void StartWithAnimation()
	{
		Astronaut a = Instantiate(
			Library.i.astronautPrefab,
			transform.position + Vector3.right * -3f - Vector3.up * 0.25f,
			Quaternion.identity
		).GetComponent<Astronaut>();
		a.generated = false;

		Chronos.i.Count(1.75f, true, () =>
		{
			a.anim.Play("A_Astro_Jump");
			anim.Play("A_Shuttle_Open");
		});
		a.Walk(new Vector2(transform.position.x, transform.position.y) - Vector2.up * 0.25f, () =>
		{
			this.Board(a);
			Chronos.i.Count(2f, true, () => 
			{
				this.TurnOn();
			});
		});
	}

	public void StartWithoutAnimation()
	{
		Astronaut a = Instantiate(Library.i.astronautPrefab, transform.position, Quaternion.identity).GetComponent<Astronaut>();
		a.generated = false;
		Board(a);
		Chronos.i.Count(2f, true, () => 
		{
			this.TurnOn();
		});
	}

	public void MultiplySpeed(float value)
	{
		vSpeed *= value;
		hSpeed *= value;
	}

	public void DivideSpeed(float value)
	{
		vSpeed /= value;
		hSpeed /= value;
	}

	public void Golden()
	{
		golden = true;
		ResetVisual();
	}

	public void ResetVisual()
	{
		if (golden)
		{
			front.color = Game.i.settings.shuttle.goldColor;
			front.sprite = Library.i.goldSprite;
			trail.material = Library.i.goldenTrail;
		}
		else
		{
			front.color = Game.i.settings.shuttle.baseColor;
			front.sprite = Library.i.baseSprite;
			trail.material = Library.i.defaultTrail;
		}
	}

	private bool boosted;
	private Chronos.Counter boostCounter;
	public void Boost(float duration)
	{
		if (boosted)
		{
			boostCounter.Reset();
			return;
		}

		boosted = true;
		AddInvisibleEffect();
		MultiplySpeed(Game.i.settings.boost.speedMultiplier);
		visuals.localScale = new Vector3(1f - Game.i.settings.boost.visualsDeformation, 1f + Game.i.settings.boost.visualsDeformation, 1f);
		bubble.color = Game.i.settings.boost.color;
		front.color = Game.i.settings.boost.color;
		trail.startColor = Game.i.settings.boost.color;
		trail.material = Library.i.rainbowTrail;
		starPS.Play();
		Game.i.generateChunks = false;
		Woofer.i.Play("boost_activated");

		boostCounter = Chronos.i.Count(duration, true, () => 
		{
			Game.i.generateChunks = true;
			DivideSpeed(Game.i.settings.boost.speedMultiplier);
			RemoveInvisibleEffect();
			this.visuals.localScale = new Vector3(1f, 1f, 1f);
			this.bubble.color = Color.white;
			this.trail.startColor = Color.white;
			this.trail.material = Library.i.defaultTrail;
			ResetVisual();
			this.boosted = false;
			this.boostCounter = null;
			this.starPS.Stop();
			if (Game.i.settings.boost.showCharge) HUD.i.HideCharge();
		});
	}

	private int invicible = 0;
	public void AddInvisibleEffect()
	{ 
		invicible++;
		RefreshInvicibleFeedback();
	}
	public void RefreshInvicibleFeedback()
	{
		if (IsInvicible()) anim.Play("A_Recovering");
		else
		{
			anim.Stop();
			bubble.color = Color.white;
		}
	}
	public void RemoveInvisibleEffect() 
	{ 
		invicible--;
		RefreshInvicibleFeedback();
	}
	public bool IsInvicible()
	{
		return invicible > 0;
	}
	public void MakeInvicibleFor(float time)
	{
		AddInvisibleEffect();
		Chronos.i.Count(time, true, () => { this.RemoveInvisibleEffect(); } );
	}

	private int freeze = 0;
	public void Freeze() { freeze++; }
	public void UnFreeze() { freeze--; }
	public bool IsFrozen() { return freeze > 0; }
	public void FreezeFor(float time)
	{
		Freeze();
		Chronos.i.Count(time, true, () => { this.UnFreeze(); });
	}

	public void Heal(int count = 1)
	{
		if (count < 1) return;
		for (int i = 0; i < count; i++)
		{
			if (health < Game.i.settings.shuttle.maxHealth) health++;
		}
	}

	public bool IsFull()
	{
		return health >= Game.i.settings.shuttle.maxHealth;
	}

	public void Damage(int count = 1)
	{
		if (count < 1) return;
		for (int i = 0; i < count; i++)
		{
			if(shielded)
			{
				LooseShield();
				return;
			}
			else
			{
				health--;
				if (health <= 0)
				{
					TurnOff();
					Game.i.Loose();
				}
				else
				{
					float slow = Game.i.settings.shuttle.damageSlowPercentage;
					float duration = Game.i.settings.shuttle.damageInvulnerabilityDuration;
					MultiplySpeed(slow / 100f);
					Chronos.i.Count(duration, true, () => this.DivideSpeed(slow / 100f));
					MakeInvicibleFor(duration);
				}
				
				Drop();
				Woofer.i.Play("glass");
				ScreenShake.i.Shake(
					Game.i.settings.shuttle.screenShakeIntensity,
					Game.i.settings.shuttle.screenShakeDuration
				);
			}
		}
	}

	public void TurnOff()
	{
		on = false;
		rb.constraints = RigidbodyConstraints2D.None;
		rb.AddForce(new Vector3(Random.Range(-0.5f, 0.5f), 1f) * Time.deltaTime * 10000f);
		if(Random.Range(0, 2) == 0) rb.AddTorque(Time.deltaTime * 10000f);
		else rb.AddTorque(Time.deltaTime * -10000f);
		Woofer.i.Play("hit");
		Freeze();
	}

	public void TurnOn()
	{
		on = true;
		rb.constraints = RigidbodyConstraints2D.FreezeAll;
		UnFreeze();
	}

	List<Astronaut> passenger = new List<Astronaut>();
	public void Board(Astronaut astro)
	{
		astro.Board(this);
		passenger.Add(astro);
		Woofer.i.Play("astronaut_in");
	}

	public void Drop(int count = 1)
	{
		for(int i = 0; i < count; i++)
		{
			if(passenger.Count > 0)
			{
				int index = Random.Range(0, passenger.Count);
				passenger[index].Die();
				passenger.RemoveAt(index);
			}
		}
	}

	public void Update()
	{
		GetInputs();
		if(Game.i.settings.boost.showCharge 
		&& boostCounter != null) HUD.i.ShowCharge(boostCounter.progression, transform.position);
	}

	public void GainShield()
	{
		shielded = true;
		shieldTransform.gameObject.SetActive(true);
		Woofer.i.Play("shield_up");
	}
	public void LooseShield()
	{
		shielded = false;
		shieldTransform.gameObject.SetActive(false);
		Woofer.i.Play("shield_down");
	}

	public void MovePassengers()
	{
		for (int i = 0; i < passenger.Count; i++)
		{
			if (passenger[i] == null) continue;

			float d = 0f;
			if (passenger.Count % 2 != 0f) d = 0.5f;
			float o = ((((float)i + d) / (float)passenger.Count) - 0.5f) * 2f;
			Vector3 pos = new Vector3(offset.x + transform.position.x + o * distanceBetween, offset.y + transform.position.y, -1f);
			passenger[i].transform.position = Vector3.Lerp(passenger[i].transform.position, pos, Time.deltaTime * positionLerp);
			passenger[i].transform.up = Vector3.Lerp(passenger[i].transform.up, transform.up, Time.deltaTime * rotationLerp);
		}
	}

	public void FixedUpdate()
	{
		if(!IsFrozen()) Move();
		ClampInBounds();
		MovePassengers();
	}

	public void GetInputs()
	{
		if (MobileInputs.i.tapDown)
		{
			horizontal = Camera.main.ScreenToWorldPoint(MobileInputs.i.tapPosition).x / Game.i.View().x;
			if (horizontal > 0) horizontal = 1f;
			if (horizontal < 0) horizontal = -1f;
		}
		else if (MobileInputs.i.tapUp) horizontal = 0f;
	}

	public int GetAstroIndex(Astronaut a)
	{
		for(int i = 0; i < passenger.Count; i++)
		{
			if (passenger[i] == a) return i;
		}
		return -1;
	}
	public int GetPassangerCount()
	{
		return passenger.Count;
	}

	public void Move()
	{
		Vector3 move = new Vector3();
		direction = Mathf.Lerp(direction, horizontal, Time.deltaTime * hLerp);
		move += Vector3.up * vSpeed *  (1f - Mathf.Abs(direction) * Game.i.settings.shuttle.horitzontalAffectOnVerticalSpeed);
		move += Vector3.right * direction * hSpeed;
		transform.position += move * Time.deltaTime;
		transform.up = move.normalized;
	}

	public void ClampInBounds()
	{
		Vector2 view = Game.i.View();
		if (transform.position.x > view.x * 0.5f)
		{
			Teleport(new Vector3(Aperture.i.transform.position.x - view.x * 0.5f, transform.position.y, transform.position.z));
		}
		else if (transform.position.x < -view.x * 0.5f)
		{
			Teleport(new Vector3(Aperture.i.transform.position.x + view.x * 0.5f, transform.position.y, transform.position.z));
		}
	}
	
	public void Teleport(Vector3 pos)
	{
		trail.Clear();
		trail.enabled = false;
		transform.position = pos;
		trail.enabled = true;
	}
}
