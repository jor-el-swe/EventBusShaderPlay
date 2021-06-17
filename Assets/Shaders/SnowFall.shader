Shader "Custom/SnowFall"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FieldSize ("SnowField Size", Float) = 3
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
            float _FieldSize;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }


            // This is probably way too many layers/flakes for full-screen. Play around with them
            #define _NUMSHEETS 10. 
            #define _NUMFLAKES 300.

            static float2 uv;

            // The classic GLSL random function
            float rnd(float x)
            {
                return frac(sin(dot(float2(x+47.49,38.2467/(x+2.3)), float2(12.9898, 78.233)))* (43758.5453));
            }

            // From https://www.shadertoy.com/view/MscXD7
            float drawFlake(float2 center, float radius)
            {
                return 1.0 - sqrt(smoothstep(0.0, radius, length(uv - center)));
            }


            fixed4 frag (v2f i) : SV_Target
            {
                uv = i.uv;
                uv *= _FieldSize;      // Scale up the space by 3
                uv = frac(uv); // Wrap around 1.0
                float3 col = 0;
                col = float3(0.6, 0.6, 0.6);
                for (float k = 1.; k <= _NUMSHEETS; k++){
                    for (float j = 1.; j <= _NUMFLAKES; j++){
                        // We want fewer flakes as they get larger
                        if (j > _NUMFLAKES/k) break;
                        
                        // Later sheets should have, on average, larger and faster flakes
                        // (to emulate parallax scrolling)
                        float size = 0.002 * k * (1. + rnd(j)/2.);            
                        float speed = -0.3*(size * .75 + rnd(k) / 1.5);
                        
                        // The two terms randomize the x pos and spread it out enough that we don't
                        // get weird hard lines where no snow passes.
                        // The last term gives us some side-to-side wobble
                        float2 center = float2(0., 0.);
                        center.x = rnd(j*k) * 1.4 + 0.1*cos(_Time.y+sin(j*k));
                        center.y = frac(sin(j) - speed * _Time.y) / 1;
                        
                        // TODO: Add in some kind of z-axis wobble
                        
                        // As the sheets get larger/faster/closer, we fade them more.
                        col +=  (1. - k/_NUMSHEETS) * drawFlake(center, size);
                    }
                   }

	               return float4(col,1.0);
            }
            
            ENDCG
        }
    }
}
