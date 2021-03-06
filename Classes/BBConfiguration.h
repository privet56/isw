#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))

// will draw the circles around the collision radius
// for debugging
#define DEBUG_DRAW_COLLIDERS 0

// the explosive force applied to the smaller rocks after a big rock has been smashed
#define SMASH_SPEED_FACTOR 0.75

#define TURN_SPEED_FACTOR 3.0
#define THRUST_SPEED_FACTOR 0.02

// a handy constant to keep around
#define BBRADIANS_TO_DEGREES 57.2958


//IPHONE: 320x480
#define DEVICE_WIDTH 768.0		//320.0 on iphone
#define DEVICE_HEIGHT 1004.0	//480.0 on iphone

// material import settings
#define BB_CONVERT_TO_4444 0

#define BB_MAX_PARTICLES 100

#define BB_FPS 30.0

// Laser1.wav
#define LASER1 @"laser1"

// explosion1.wav
#define EXPLOSION1 @"explosion1"
