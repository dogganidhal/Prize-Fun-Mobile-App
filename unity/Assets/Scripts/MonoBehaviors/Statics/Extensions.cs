using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Extensions
{
	public static bool IsYourself(this Transform transform, Transform thing)
	{
		foreach (Transform t in transform.GetComponentsInChildren<Transform>())
		{
			if (thing == t.transform) return true;
		}
		return false;
	}

	public static bool IsGrounded(this Transform transform, float distance = 1f, Vector3 offset = new Vector3())
	{
		RaycastHit[] hits = Physics.RaycastAll(transform.position + offset + transform.up * 0.1f, -transform.up, distance + 0.1f);
		foreach (RaycastHit h in hits)
		{
			if (!transform.IsYourself(h.transform) && !h.collider.isTrigger) return true;
		}
		return false;
	}
}
