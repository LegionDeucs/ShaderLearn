Shader "Unlit/TestShader"
{
    Properties
    {
        _PositionMultiplier("Position Multiplier", float) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
 
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
 
            #include "UnityCG.cginc"
            float _PositionMultiplier;

 
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 position: TEXCOORD1;
                float2 uv : TEXCOORD0;
            };
 
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }
        
            bool CheckCondition(float2 position)
            {
                float checkDist = 0.05;
                float checkVal = 0;
 
                return position.x <= checkVal + checkDist && position.x >= checkVal - checkDist &
                 position.y <= checkVal + checkDist && position.y >= checkVal - checkDist;
            }
 
            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 color = i.position * _PositionMultiplier;
                if(CheckCondition(i.position))
                {
                    color = fixed3(0,0,1);
                }
                else
                {
                    color.r = step(1, color.r);
                    color.g = step(1, color.g);
                }
                return fixed4(color, 1);
            }
            ENDCG
        }
    }
}