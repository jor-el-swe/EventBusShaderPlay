Shader "Custom/shaderTest234234"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            #define PI 3.14159265359
            float2x2 rotate2d(float _angle){
                return float2x2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
            }
            fixed4 frag (v2f i) : SV_Target
            {

                float2 uv = i.uv;
                // sample the texture
                uv *= 3.0;      // Scale up the space by 3
                uv = frac(uv); // Wrap around 1.0
                uv = mul(uv,rotate2d( -_Time.a ));
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                col = fixed4(uv.x,uv.y,0,1);
                return col;
            }
            ENDCG
        }
    }
}
