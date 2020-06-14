using UnityEngine;
using UnityEngine.UI;

public class VirtualJostick : MonoBehaviour
{
    public RectTransform self;
    public RectTransform center;

    public Image back;
    public Image knob;

    private bool shown = false;

    void Update()
    {
        if (MobileJoystick.i != null && MobileJoystick.i.activated)
            Set(MobileJoystick.i.startPosition, MobileJoystick.i.direction, MobileJoystick.i.radius);
        else if(shown) Hide();

    }

    public void Hide()
    {
        back.enabled = false;
        knob.enabled = false;
        shown = false;
    }

    public void Show()
    {
        back.enabled = true;
        knob.enabled = true;
        shown = true;
    }

    public void Set(Vector2 position, Vector2 direction, float radius)
    {
        if (!shown) Show();

        self.position = position;
        self.sizeDelta = new Vector2(radius, radius);
        center.localPosition = new Vector2(
            self.sizeDelta.x/2 * direction.x,
            self.sizeDelta.y/2 * direction.y
        );
    }
}
