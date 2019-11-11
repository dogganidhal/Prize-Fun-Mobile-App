extern "C" void RegisterStaticallyLinkedModulesGranular()
{
	void RegisterModule_SharedInternals();
	RegisterModule_SharedInternals();

	void RegisterModule_Core();
	RegisterModule_Core();

	void RegisterModule_Animation();
	RegisterModule_Animation();

	void RegisterModule_Audio();
	RegisterModule_Audio();

	void RegisterModule_ParticleSystem();
	RegisterModule_ParticleSystem();

	void RegisterModule_Physics();
	RegisterModule_Physics();

	void RegisterModule_Physics2D();
	RegisterModule_Physics2D();

	void RegisterModule_TextRendering();
	RegisterModule_TextRendering();

	void RegisterModule_UI();
	RegisterModule_UI();

	void RegisterModule_UnityConnect();
	RegisterModule_UnityConnect();

	void RegisterModule_AndroidJNI();
	RegisterModule_AndroidJNI();

	void RegisterModule_InputLegacy();
	RegisterModule_InputLegacy();

	void RegisterModule_IMGUI();
	RegisterModule_IMGUI();

	void RegisterModule_UnityWebRequest();
	RegisterModule_UnityWebRequest();

	void RegisterModule_UnityAnalytics();
	RegisterModule_UnityAnalytics();

	void RegisterModule_TLS();
	RegisterModule_TLS();

	void RegisterModule_JSONSerialize();
	RegisterModule_JSONSerialize();

}

template <typename T> void RegisterUnityClass(const char*);
template <typename T> void RegisterStrippedType(int, const char*, const char*);

void InvokeRegisterStaticallyLinkedModuleClasses()
{
	// Do nothing (we're in stripping mode)
}

namespace ObjectProduceTestTypes { class Derived; } 
namespace ObjectProduceTestTypes { class SubDerived; } 
class EditorExtension; template <> void RegisterUnityClass<EditorExtension>(const char*);
namespace Unity { class Component; } template <> void RegisterUnityClass<Unity::Component>(const char*);
class Behaviour; template <> void RegisterUnityClass<Behaviour>(const char*);
class Animation; 
class Animator; template <> void RegisterUnityClass<Animator>(const char*);
class AudioBehaviour; template <> void RegisterUnityClass<AudioBehaviour>(const char*);
class AudioListener; template <> void RegisterUnityClass<AudioListener>(const char*);
class AudioSource; template <> void RegisterUnityClass<AudioSource>(const char*);
class AudioFilter; 
class AudioChorusFilter; 
class AudioDistortionFilter; 
class AudioEchoFilter; 
class AudioHighPassFilter; 
class AudioLowPassFilter; 
class AudioReverbFilter; 
class AudioReverbZone; 
class Camera; template <> void RegisterUnityClass<Camera>(const char*);
namespace UI { class Canvas; } template <> void RegisterUnityClass<UI::Canvas>(const char*);
namespace UI { class CanvasGroup; } template <> void RegisterUnityClass<UI::CanvasGroup>(const char*);
namespace Unity { class Cloth; } 
class Collider2D; template <> void RegisterUnityClass<Collider2D>(const char*);
class BoxCollider2D; template <> void RegisterUnityClass<BoxCollider2D>(const char*);
class CapsuleCollider2D; 
class CircleCollider2D; template <> void RegisterUnityClass<CircleCollider2D>(const char*);
class CompositeCollider2D; 
class EdgeCollider2D; 
class PolygonCollider2D; 
class TilemapCollider2D; 
class ConstantForce; 
class Effector2D; 
class AreaEffector2D; 
class BuoyancyEffector2D; 
class PlatformEffector2D; 
class PointEffector2D; 
class SurfaceEffector2D; 
class FlareLayer; template <> void RegisterUnityClass<FlareLayer>(const char*);
class GUIElement; template <> void RegisterUnityClass<GUIElement>(const char*);
namespace TextRenderingPrivate { class GUIText; } 
class GUITexture; 
class GUILayer; template <> void RegisterUnityClass<GUILayer>(const char*);
class GridLayout; 
class Grid; 
class Tilemap; 
class Halo; 
class HaloLayer; 
class IConstraint; 
class AimConstraint; 
class LookAtConstraint; 
class ParentConstraint; 
class PositionConstraint; 
class RotationConstraint; 
class ScaleConstraint; 
class Joint2D; 
class AnchoredJoint2D; 
class DistanceJoint2D; 
class FixedJoint2D; 
class FrictionJoint2D; 
class HingeJoint2D; 
class SliderJoint2D; 
class SpringJoint2D; 
class WheelJoint2D; 
class RelativeJoint2D; 
class TargetJoint2D; 
class LensFlare; 
class Light; template <> void RegisterUnityClass<Light>(const char*);
class LightProbeGroup; 
class LightProbeProxyVolume; 
class MonoBehaviour; template <> void RegisterUnityClass<MonoBehaviour>(const char*);
class NavMeshAgent; 
class NavMeshObstacle; 
class OffMeshLink; 
class ParticleSystemForceField; 
class PhysicsUpdateBehaviour2D; 
class ConstantForce2D; 
class PlayableDirector; 
class Projector; 
class ReflectionProbe; template <> void RegisterUnityClass<ReflectionProbe>(const char*);
class Skybox; 
class SortingGroup; 
class StreamingController; 
class Terrain; 
class VideoPlayer; 
class VisualEffect; 
class WindZone; 
namespace UI { class CanvasRenderer; } template <> void RegisterUnityClass<UI::CanvasRenderer>(const char*);
class Collider; template <> void RegisterUnityClass<Collider>(const char*);
class BoxCollider; 
class CapsuleCollider; 
class CharacterController; 
class MeshCollider; template <> void RegisterUnityClass<MeshCollider>(const char*);
class SphereCollider; 
class TerrainCollider; 
class WheelCollider; 
class FakeComponent; 
namespace Unity { class Joint; } 
namespace Unity { class CharacterJoint; } 
namespace Unity { class ConfigurableJoint; } 
namespace Unity { class FixedJoint; } 
namespace Unity { class HingeJoint; } 
namespace Unity { class SpringJoint; } 
class LODGroup; 
class MeshFilter; template <> void RegisterUnityClass<MeshFilter>(const char*);
class OcclusionArea; 
class OcclusionPortal; 
class ParticleSystem; template <> void RegisterUnityClass<ParticleSystem>(const char*);
class Renderer; template <> void RegisterUnityClass<Renderer>(const char*);
class BillboardRenderer; 
class LineRenderer; 
class RendererFake; 
class MeshRenderer; template <> void RegisterUnityClass<MeshRenderer>(const char*);
class ParticleSystemRenderer; template <> void RegisterUnityClass<ParticleSystemRenderer>(const char*);
class SkinnedMeshRenderer; 
class SpriteMask; 
class SpriteRenderer; template <> void RegisterUnityClass<SpriteRenderer>(const char*);
class SpriteShapeRenderer; 
class TilemapRenderer; 
class TrailRenderer; 
class VFXRenderer; 
class Rigidbody; 
class Rigidbody2D; template <> void RegisterUnityClass<Rigidbody2D>(const char*);
namespace TextRenderingPrivate { class TextMesh; } 
class Transform; template <> void RegisterUnityClass<Transform>(const char*);
namespace UI { class RectTransform; } template <> void RegisterUnityClass<UI::RectTransform>(const char*);
class Tree; 
class WorldAnchor; 
class GameObject; template <> void RegisterUnityClass<GameObject>(const char*);
class NamedObject; template <> void RegisterUnityClass<NamedObject>(const char*);
class AssetBundle; 
class AssetBundleManifest; 
class ScriptedImporter; 
class AudioMixer; 
class AudioMixerController; 
class AudioMixerGroup; 
class AudioMixerGroupController; 
class AudioMixerSnapshot; 
class AudioMixerSnapshotController; 
class Avatar; 
class AvatarMask; 
class BillboardAsset; 
class ComputeShader; template <> void RegisterUnityClass<ComputeShader>(const char*);
class Flare; 
namespace TextRendering { class Font; } template <> void RegisterUnityClass<TextRendering::Font>(const char*);
class GameObjectRecorder; 
class LightProbes; 
class LocalizationAsset; 
class Material; template <> void RegisterUnityClass<Material>(const char*);
class ProceduralMaterial; 
class Mesh; template <> void RegisterUnityClass<Mesh>(const char*);
class Motion; template <> void RegisterUnityClass<Motion>(const char*);
class AnimationClip; template <> void RegisterUnityClass<AnimationClip>(const char*);
class PreviewAnimationClip; 
class NavMeshData; 
class OcclusionCullingData; 
class PhysicMaterial; 
class PhysicsMaterial2D; 
class PreloadData; template <> void RegisterUnityClass<PreloadData>(const char*);
class RuntimeAnimatorController; template <> void RegisterUnityClass<RuntimeAnimatorController>(const char*);
class AnimatorController; template <> void RegisterUnityClass<AnimatorController>(const char*);
class AnimatorOverrideController; template <> void RegisterUnityClass<AnimatorOverrideController>(const char*);
class SampleClip; template <> void RegisterUnityClass<SampleClip>(const char*);
class AudioClip; template <> void RegisterUnityClass<AudioClip>(const char*);
class Shader; template <> void RegisterUnityClass<Shader>(const char*);
class ShaderVariantCollection; 
class SpeedTreeWindAsset; 
class Sprite; template <> void RegisterUnityClass<Sprite>(const char*);
class SpriteAtlas; template <> void RegisterUnityClass<SpriteAtlas>(const char*);
class SubstanceArchive; 
class TerrainData; 
class TerrainLayer; 
class TextAsset; template <> void RegisterUnityClass<TextAsset>(const char*);
class CGProgram; 
class MonoScript; template <> void RegisterUnityClass<MonoScript>(const char*);
class Texture; template <> void RegisterUnityClass<Texture>(const char*);
class BaseVideoTexture; 
class MovieTexture; 
class WebCamTexture; 
class CubemapArray; template <> void RegisterUnityClass<CubemapArray>(const char*);
class LowerResBlitTexture; template <> void RegisterUnityClass<LowerResBlitTexture>(const char*);
class ProceduralTexture; 
class RenderTexture; template <> void RegisterUnityClass<RenderTexture>(const char*);
class CustomRenderTexture; 
class SparseTexture; 
class Texture2D; template <> void RegisterUnityClass<Texture2D>(const char*);
class Cubemap; template <> void RegisterUnityClass<Cubemap>(const char*);
class Texture2DArray; template <> void RegisterUnityClass<Texture2DArray>(const char*);
class Texture3D; template <> void RegisterUnityClass<Texture3D>(const char*);
class VideoClip; 
class VisualEffectObject; 
class VisualEffectAsset; 
class VisualEffectSubgraph; 
class VisualEffectSubgraphBlock; 
class VisualEffectSubgraphOperator; 
class VisualEffectResource; 
class EmptyObject; 
class GameManager; template <> void RegisterUnityClass<GameManager>(const char*);
class GlobalGameManager; template <> void RegisterUnityClass<GlobalGameManager>(const char*);
class AudioManager; template <> void RegisterUnityClass<AudioManager>(const char*);
class BuildSettings; template <> void RegisterUnityClass<BuildSettings>(const char*);
class ClusterInputManager; 
class DelayedCallManager; template <> void RegisterUnityClass<DelayedCallManager>(const char*);
class GraphicsSettings; template <> void RegisterUnityClass<GraphicsSettings>(const char*);
class InputManager; template <> void RegisterUnityClass<InputManager>(const char*);
class MonoManager; template <> void RegisterUnityClass<MonoManager>(const char*);
class NavMeshProjectSettings; 
class Physics2DSettings; template <> void RegisterUnityClass<Physics2DSettings>(const char*);
class PhysicsManager; template <> void RegisterUnityClass<PhysicsManager>(const char*);
class PlayerSettings; template <> void RegisterUnityClass<PlayerSettings>(const char*);
class QualitySettings; template <> void RegisterUnityClass<QualitySettings>(const char*);
class ResourceManager; template <> void RegisterUnityClass<ResourceManager>(const char*);
class RuntimeInitializeOnLoadManager; template <> void RegisterUnityClass<RuntimeInitializeOnLoadManager>(const char*);
class ScriptMapper; template <> void RegisterUnityClass<ScriptMapper>(const char*);
class StreamingManager; 
class TagManager; template <> void RegisterUnityClass<TagManager>(const char*);
class TimeManager; template <> void RegisterUnityClass<TimeManager>(const char*);
class UnityConnectSettings; template <> void RegisterUnityClass<UnityConnectSettings>(const char*);
class VFXManager; 
class LevelGameManager; template <> void RegisterUnityClass<LevelGameManager>(const char*);
class LightmapSettings; template <> void RegisterUnityClass<LightmapSettings>(const char*);
class NavMeshSettings; 
class OcclusionCullingSettings; 
class RenderSettings; template <> void RegisterUnityClass<RenderSettings>(const char*);
class NativeObjectType; 
class PropertyModificationsTargetTestObject; 
class SerializableManagedHost; 
class SerializableManagedRefTestClass; 
namespace ObjectProduceTestTypes { class SiblingDerived; } 
class TestObjectVectorPairStringBool; 
class TestObjectWithSerializedAnimationCurve; 
class TestObjectWithSerializedArray; 
class TestObjectWithSerializedMapStringBool; 
class TestObjectWithSerializedMapStringNonAlignedStruct; 
class TestObjectWithSpecialLayoutOne; 
class TestObjectWithSpecialLayoutTwo; 

void RegisterAllClasses()
{
void RegisterBuiltinTypes();
RegisterBuiltinTypes();
	//Total: 79 non stripped classes
	//0. Camera
	RegisterUnityClass<Camera>("Core");
	//1. Behaviour
	RegisterUnityClass<Behaviour>("Core");
	//2. Unity::Component
	RegisterUnityClass<Unity::Component>("Core");
	//3. EditorExtension
	RegisterUnityClass<EditorExtension>("Core");
	//4. ReflectionProbe
	RegisterUnityClass<ReflectionProbe>("Core");
	//5. QualitySettings
	RegisterUnityClass<QualitySettings>("Core");
	//6. GlobalGameManager
	RegisterUnityClass<GlobalGameManager>("Core");
	//7. GameManager
	RegisterUnityClass<GameManager>("Core");
	//8. Renderer
	RegisterUnityClass<Renderer>("Core");
	//9. Shader
	RegisterUnityClass<Shader>("Core");
	//10. NamedObject
	RegisterUnityClass<NamedObject>("Core");
	//11. Material
	RegisterUnityClass<Material>("Core");
	//12. Light
	RegisterUnityClass<Light>("Core");
	//13. MeshFilter
	RegisterUnityClass<MeshFilter>("Core");
	//14. MeshRenderer
	RegisterUnityClass<MeshRenderer>("Core");
	//15. GraphicsSettings
	RegisterUnityClass<GraphicsSettings>("Core");
	//16. Mesh
	RegisterUnityClass<Mesh>("Core");
	//17. Texture
	RegisterUnityClass<Texture>("Core");
	//18. Texture2D
	RegisterUnityClass<Texture2D>("Core");
	//19. Cubemap
	RegisterUnityClass<Cubemap>("Core");
	//20. Texture3D
	RegisterUnityClass<Texture3D>("Core");
	//21. Texture2DArray
	RegisterUnityClass<Texture2DArray>("Core");
	//22. CubemapArray
	RegisterUnityClass<CubemapArray>("Core");
	//23. RenderTexture
	RegisterUnityClass<RenderTexture>("Core");
	//24. GUIElement
	RegisterUnityClass<GUIElement>("Core");
	//25. GUILayer
	RegisterUnityClass<GUILayer>("Core");
	//26. GameObject
	RegisterUnityClass<GameObject>("Core");
	//27. MonoBehaviour
	RegisterUnityClass<MonoBehaviour>("Core");
	//28. TextAsset
	RegisterUnityClass<TextAsset>("Core");
	//29. ComputeShader
	RegisterUnityClass<ComputeShader>("Core");
	//30. LowerResBlitTexture
	RegisterUnityClass<LowerResBlitTexture>("Core");
	//31. PreloadData
	RegisterUnityClass<PreloadData>("Core");
	//32. UI::RectTransform
	RegisterUnityClass<UI::RectTransform>("Core");
	//33. Transform
	RegisterUnityClass<Transform>("Core");
	//34. SpriteRenderer
	RegisterUnityClass<SpriteRenderer>("Core");
	//35. Sprite
	RegisterUnityClass<Sprite>("Core");
	//36. SpriteAtlas
	RegisterUnityClass<SpriteAtlas>("Core");
	//37. UI::CanvasGroup
	RegisterUnityClass<UI::CanvasGroup>("UI");
	//38. UI::CanvasRenderer
	RegisterUnityClass<UI::CanvasRenderer>("UI");
	//39. UI::Canvas
	RegisterUnityClass<UI::Canvas>("UI");
	//40. TextRendering::Font
	RegisterUnityClass<TextRendering::Font>("TextRendering");
	//41. Collider
	RegisterUnityClass<Collider>("Physics");
	//42. Rigidbody2D
	RegisterUnityClass<Rigidbody2D>("Physics2D");
	//43. Animator
	RegisterUnityClass<Animator>("Animation");
	//44. AnimatorOverrideController
	RegisterUnityClass<AnimatorOverrideController>("Animation");
	//45. RuntimeAnimatorController
	RegisterUnityClass<RuntimeAnimatorController>("Animation");
	//46. ParticleSystem
	RegisterUnityClass<ParticleSystem>("ParticleSystem");
	//47. ParticleSystemRenderer
	RegisterUnityClass<ParticleSystemRenderer>("ParticleSystem");
	//48. AudioClip
	RegisterUnityClass<AudioClip>("Audio");
	//49. SampleClip
	RegisterUnityClass<SampleClip>("Audio");
	//50. AudioSource
	RegisterUnityClass<AudioSource>("Audio");
	//51. AudioBehaviour
	RegisterUnityClass<AudioBehaviour>("Audio");
	//52. Collider2D
	RegisterUnityClass<Collider2D>("Physics2D");
	//53. MeshCollider
	RegisterUnityClass<MeshCollider>("Physics");
	//54. MonoScript
	RegisterUnityClass<MonoScript>("Core");
	//55. UnityConnectSettings
	RegisterUnityClass<UnityConnectSettings>("UnityConnect");
	//56. AudioManager
	RegisterUnityClass<AudioManager>("Audio");
	//57. PlayerSettings
	RegisterUnityClass<PlayerSettings>("Core");
	//58. PhysicsManager
	RegisterUnityClass<PhysicsManager>("Physics");
	//59. TimeManager
	RegisterUnityClass<TimeManager>("Core");
	//60. InputManager
	RegisterUnityClass<InputManager>("Core");
	//61. TagManager
	RegisterUnityClass<TagManager>("Core");
	//62. DelayedCallManager
	RegisterUnityClass<DelayedCallManager>("Core");
	//63. BuildSettings
	RegisterUnityClass<BuildSettings>("Core");
	//64. RuntimeInitializeOnLoadManager
	RegisterUnityClass<RuntimeInitializeOnLoadManager>("Core");
	//65. ResourceManager
	RegisterUnityClass<ResourceManager>("Core");
	//66. ScriptMapper
	RegisterUnityClass<ScriptMapper>("Core");
	//67. MonoManager
	RegisterUnityClass<MonoManager>("Core");
	//68. Physics2DSettings
	RegisterUnityClass<Physics2DSettings>("Physics2D");
	//69. AnimationClip
	RegisterUnityClass<AnimationClip>("Animation");
	//70. Motion
	RegisterUnityClass<Motion>("Animation");
	//71. AudioListener
	RegisterUnityClass<AudioListener>("Audio");
	//72. BoxCollider2D
	RegisterUnityClass<BoxCollider2D>("Physics2D");
	//73. AnimatorController
	RegisterUnityClass<AnimatorController>("Animation");
	//74. LightmapSettings
	RegisterUnityClass<LightmapSettings>("Core");
	//75. LevelGameManager
	RegisterUnityClass<LevelGameManager>("Core");
	//76. FlareLayer
	RegisterUnityClass<FlareLayer>("Core");
	//77. RenderSettings
	RegisterUnityClass<RenderSettings>("Core");
	//78. CircleCollider2D
	RegisterUnityClass<CircleCollider2D>("Physics2D");

}
