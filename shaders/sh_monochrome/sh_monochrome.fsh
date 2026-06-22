varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    float gray =
        col.r * 0.299 +
        col.g * 0.587 +
        col.b * 0.114;

    gl_FragColor =
        vec4(gray, gray, gray, col.a) *
        v_vColour;
}