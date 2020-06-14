Shader "Barkintosh/Skybox/Fade"
{
    Properties
    {
        _SkyColor1("Top Color", Color) = (1, 1, 1, 1)
        _SkyColor2("Bottom Color", Color) = (1, 1, 1, 1)
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    struct v2f
    {
        float4 position : SV_POSITION;
        float3 texcoord : TEXCOORD0;
    };
    
    half3 _SkyColor1;
    half3 _SkyColor2;
    
    v2f vert(appdata v)
    {
        v2f o;
        o.position = UnityObjectToClipPos(v.position);
        o.texcoord = v.texcoord;
        return o;
    }
    
    half4 frag(v2f i) : COLOR
    {
        float3 v = normalize(i.texcoord);
        half3 c_sky = lerp(_SkyColor2, _SkyColor1, v.y * 2);
        return half4(c_sky, 0);
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
    CustomEditor "HorizonWithSunSkyboxInspector"
}