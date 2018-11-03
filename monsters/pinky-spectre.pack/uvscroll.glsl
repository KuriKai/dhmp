highp vec2 scrolledUV(highp vec2 uv, highp float mapTime)
{
    return uv + vec2(0.0, mapTime * 0.3);
}