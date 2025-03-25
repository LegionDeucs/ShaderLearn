Shader "Unlit/Shader 1 Unlit"
{
    Properties
    {
        _PositionMultiplier("Position Multiplier", float) = 2
        _Anchor("Anchor", Vector) = (0.15, 0.15, 0, 0)
        _Color("Color", Color) = (1,0,0,1)
        _Size("Size", float) = 0.3
        _TileCount("TileCount", int) = 6
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
            float4 _Mouse;
            float _PositionMultiplier;
            float4 _Anchor;
            float4 _Color;
            float _Size;
            float _TileCount;

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

            float rect(float2 pt, float2 size, float2 center)
            {
                float2 p = pt-center;
                float2 halfSize = size * 0.5;
                float2 test = step(-halfSize,p) - step(halfSize, p);
                return test.x * test.y;
            }
            
            float rect(float2 pt, float2 anchor, float2 size, float2 center)
            {
                float2 p = pt - center;
                float2 halfSize = size * 0.5;
                float2 test = step(-halfSize - anchor.xy, p) - step(halfSize - anchor.xy, p);
                return test.x * test.y;
            }

            float2x2 getRotationMatrix (float theta)
            {
                float s = sin(theta);
                float c = cos(theta);

                return float2x2(c, -s, s, c);
            }

            float2x2 getScaleMatrix(float scale)
            {
                return float2x2(scale, 0, 0, scale);
            }
                       
            bool CheckCondition(float2 position)
            {
                float checkDist = 0.05;
                float checkVal = 0;
 
                return position.x <= checkVal + checkDist && position.x >= checkVal - checkDist && 
                position.y <= checkVal + checkDist && position.y >= checkVal - checkDist;
            }

            float circle(float2 pt, float2 center, float radius)
            {
                float2 p = pt - center;
                return 1 - step(radius, length(p));
            }

            float circle(float2 pt, float2 center, float radius, bool soften)
            {
                float2 p = pt - center;
                float edge = (soften)? radius * 0.005:0.0;
                return 1 - smoothstep(radius - edge, radius + edge, length(p));
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 center = _Anchor.zw;
                //fixed2 pos = frac(i.uv * _TileCount);
                fixed2 pos = frac(i.position * _TileCount);
                float2 size = _Size;
                float2x2 matr = getRotationMatrix(_Time.y);
                float2x2 mats = getScaleMatrix(sin(_Time.y +1)/3 +0.5);

                float2x2 mat = mul(matr, mats);

                float2 pt = mul(mat, pos - center) + center;

                fixed3 color = _Color * rect(pt, _Anchor.xy, size, center);
                if(CheckCondition(i.position))
                    return fixed4(0,0,1,1);
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}