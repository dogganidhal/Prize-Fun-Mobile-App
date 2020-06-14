using UnityEngine;
public class RandomMaterialApplier : MonoBehaviour
{
    public Material[] materials;

    void Start()
    {
        if (gameObject.TryGetComponent<MeshRenderer>(out MeshRenderer mr))
        {
            mr.material = materials[Random.Range(0, materials.Length)];
        }
        else Destroy(this);
    }
}
