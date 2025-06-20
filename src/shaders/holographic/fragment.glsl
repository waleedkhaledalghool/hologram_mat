uniform float uTime;
uniform vec3 uColor;

varying vec3 vPosition;
varying vec3 vNormal;

void main()
{
    // Normal
    vec3 noraml = normalize(vNormal);
    if(!gl_FrontFacing)
        noraml *= -1.0;

    // Strips
    float strips = mod((vPosition.y + uTime * 0.02) * 20.0,1.0);
    strips = pow(strips,3.0);
    

    // Fresnel
    vec3 viewDierction = normalize(vPosition - cameraPosition);
    float fresenl = dot(viewDierction,noraml) + 1.0; 
    fresenl = pow(fresenl,2.0);


    // Falloff
    float falloff = smoothstep(0.8,0.0, fresenl);


    // Holographic
    float holographic = fresenl * strips;
    holographic += fresenl * 1.25;
    holographic *= falloff;
    // Final color
    gl_FragColor = vec4(uColor,holographic);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}