//random functions
#define PI 3.14159265359
#define TWOPI 6.28318530718

//Random functions
uint wang_hash(inout uint seed)
{
    seed = uint(seed ^ uint(61)) ^ uint(seed >> uint(16));
    seed *= uint(9);
    seed = seed ^ (seed >> 4);
    seed *= uint(0x27d4eb2d);
    seed = seed ^ (seed >> 15);
    return seed;
}
 
float RandomFloat01(inout uint seed)
{
    return float(wang_hash(seed)) / 4294967296.0;
}

vec3 RandomUnitVector(inout uint seed)
{
    float z = RandomFloat01(seed) * 2.0f - 1.0f;
    float a = RandomFloat01(seed) * TWOPI;
    float r = sqrt(1.0f - z * z);
    float x = r * cos(a);
    float y = r * sin(a);
    return vec3(x, y, z);
}

uint getRandSeed(vec2 uv, int frame){ 
	return  uint(uv.x*3772) + uint(uv.y*78223) + uint(frame)*uint(26699); 
}