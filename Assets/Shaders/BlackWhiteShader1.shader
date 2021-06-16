Shader "Custom/BlackWhiteShader1"
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


            static float3 colorA = float3(0.149,0.141,0.912);
            static float3 colorB = float3(1.000,0.833,0.224);
            fixed4 sinColors() {
                float3 color = 0;

                float pct = abs(sin(_Time.y));

                // Mix uses pct (a value from 0-1) to
                // mix the two colors
                color = lerp(colorA, colorB, pct);

                return float4(color,1.0);
            }

            fixed4 propeller(float2 uv){
                float3 color = 0.0;

                float2 pos = float2(0.5,0.5)-uv;

                float r = length(pos)*2.1;
                float a = atan2(pos.x, pos.y);

                float f = cos(a*3.);
                 //f = abs(cos(a*3.));
                 //f = abs(cos(a*2.5))*.5+.3;
                 //f = abs(cos(a*12.)*sin(a*3.))*.8+.1;
                  //f = smoothstep(-.5,1., cos(a*10.))*0.2+0.5;

                 //play with animation
                 f = cos(5*a*sin(_Time.y));

                 color = 1.-smoothstep(f,f+0.02,r);
                 color = 1.-smoothstep(f,f,r*sin(2*_Time.y)*3);

                return float4(color, 1.0);
            }

            #define PI 3.14159265359
            float2x2 rotate2d(float _angle){
                return float2x2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
            }

            fixed4 rotatePropeller(float2 uv){
                uv -= 0.5;
                uv = mul(uv,rotate2d( -_Time.a ));
                uv += 0.5;
                return propeller(uv);
            }
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                
                // sample1
                /*
                fixed4 col = float4(uv.y,uv.x,0,0);

                return col;*/

                //sample2, sine colors
                //return sinColors();

                //sample 3, propeller
                //return propeller(uv);

                //sample4, rotating propeller
                //return rotatePropeller(uv);

                //sample5, scaling up the uv
                uv *= 10.0;      // Scale up the space by 3
                uv = frac(uv); // Wrap around 1.0
                return rotatePropeller(uv);              

            }


            ENDCG
        }
    }
}
