varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float saturation;

void main()
{
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);

    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    vec3 finalColor = mix(vec3(gray), color.rgb, saturation);

    gl_FragColor = vec4(finalColor, color.a);
}