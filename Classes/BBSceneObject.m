#import "BBSceneObject.h"
#import "BBSceneController.h"
#import "BBInputViewController.h"
#import "BBCollider.h"

#pragma mark Spinny Square mesh
static CGFloat spinnySquareVertices[8] = {
-0.5f, -0.5f,
0.5f,  -0.5f,
-0.5f,  0.5f,
0.5f,   0.5f,
};

static CGFloat spinnySquareColors[16] = {
1.0, 1.0,   0, 1.0,
0,   1.0, 1.0, 1.0,
0,     0,   0,   0,
1.0,   0, 1.0, 1.0,
};

@implementation BBSceneObject

@synthesize translation,rotation,scale,active,mesh,matrix,meshBounds,collider;
@synthesize soundSourceObject;

- (id) init
{
	self = [super init];
	if (self != nil)
	{
		translation = BBPointMake(0.0, 0.0, 0.0);
		rotation = BBPointMake(0.0, 0.0, 0.0);
		scale = BBPointMake(1.0, 1.0, 1.0);
		matrix = (CGFloat *) malloc(16 * sizeof(CGFloat));
		active = NO;
		meshBounds = CGRectZero;
		self.collider = nil;
		soundSourceObject = [[EWSoundSourceObject alloc] init];
		soundSourceObject.maxDistance = 600.0;
	}
	return self;
}

// called once when the object is first created.
-(void)awake
{
	soundSourceObject.objectPosition = translation;
	CGFloat angle_in_radians = rotation.z/BBRADIANS_TO_DEGREES;
	soundSourceObject.atDirection = BBPointMake(-sinf(angle_in_radians), cosf(angle_in_radians), 0.0);

	//TEXTURE SUPPORT -> deactivate the whole function???
	mesh = [[BBMesh alloc] initWithVertexes:spinnySquareVertices 
						vertexCount:4 
						vertexStride:2
						renderStyle:GL_TRIANGLE_STRIP];
	mesh.colors = spinnySquareColors;
	mesh.colorStride = 4;
}

-(CGRect) meshBounds
{
	if (CGRectEqualToRect(meshBounds, CGRectZero))
	{
		meshBounds = [BBMesh meshBounds:mesh scale:scale];
	}
	return meshBounds;
}

// called once every frame
-(void)update
{
	glPushMatrix();
	glLoadIdentity();
	
	// move to my position
	glTranslatef(translation.x, translation.y, translation.z);
	
	// rotate
	glRotatef(rotation.x, 1.0f, 0.0f, 0.0f);
	glRotatef(rotation.y, 0.0f, 1.0f, 0.0f);
	glRotatef(rotation.z, 0.0f, 0.0f, 1.0f);
	
	//scale
	glScalef(scale.x, scale.y, scale.z);
	// save the matrix transform
	glGetFloatv(GL_MODELVIEW_MATRIX, matrix);
	//restore the matrix
	glPopMatrix();
	if (collider != nil) [collider updateCollider:self];
	self.soundSourceObject.objectPosition = translation;
	CGFloat angle_in_radians = rotation.z/BBRADIANS_TO_DEGREES;
	soundSourceObject.atDirection = BBPointMake(-sinf(angle_in_radians), cosf(angle_in_radians), 0.0);
	[self.soundSourceObject update];
}

// called once every frame
-(void)render
{
	if (!mesh || !active) return; // if we do not have a mesh, no need to render
	// clear the matrix
	glPushMatrix();
	glLoadIdentity();
	glMultMatrixf(matrix);
	[mesh render];	
	glPopMatrix();
}

- (void) soundDidFinishPlaying:(NSNumber*)source_number
{
	[self.soundSourceObject soundDidFinishPlaying:source_number];
}


- (void) dealloc
{
	[mesh release];
	[collider release];
	free(matrix);	
	[soundSourceObject release];
	[super dealloc];
}

@end
