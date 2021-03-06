#import "BBMissile.h"
#import "BBRock.h"
#import "BBCollider.h"

#pragma mark Missile mesh

static NSInteger BBMissileVertexStride = 2;
static NSInteger BBMissileColorStride = 4;

static NSInteger BBMissileOutlineVertexesCount = 3;
static CGFloat BBMissileOutlineVertexes[6] = 
{-0.5, 0.0,  0.5,0.0,  0.0, 9.0};

static CGFloat BBMissileColorValues[12] = 
{
	0.8,0.1,0.1,1.0,
	0.8,0.1,0.1,1.0,
	0.8,0.1,0.1,1.0
};

@implementation BBMissile
-(void)awake
{
	mesh = [[BBMesh alloc] initWithVertexes:BBMissileOutlineVertexes 
															vertexCount:BBMissileOutlineVertexesCount 
															vertexStride:BBMissileVertexStride
															renderStyle:GL_TRIANGLES];
	mesh.colors = BBMissileColorValues;
	mesh.colorStride = BBMissileColorStride;
	self.collider = [BBCollider collider];
	[self.collider setCheckForCollision:YES];
}

-(void)checkArenaBounds
{
	BOOL outOfArena = NO;
	if (translation.x > ((DEVICE_HEIGHT/2.0) + CGRectGetWidth(self.meshBounds)/2.0)) outOfArena = YES; 
	if (translation.x < (-(DEVICE_HEIGHT/2.0) - CGRectGetWidth(self.meshBounds)/2.0)) outOfArena = YES; 
	
	if (translation.y > ((DEVICE_WIDTH/2.0) + CGRectGetHeight(self.meshBounds)/2.0)) outOfArena = YES; 
	if (translation.y < (-(DEVICE_WIDTH/2.0) - CGRectGetHeight(self.meshBounds)/2.0)) outOfArena = YES; 
	
	if (outOfArena)
	{
		[[BBSceneController sharedSceneController] removeObjectFromScene:self];
	}
}

- (void)didCollideWith:(BBSceneObject*)sceneObject; 
{
	return;	//NO COLLISION (TODO later)
	
	// if we did not hit a rock, then get out early
	if (![sceneObject isKindOfClass:[BBRock class]]) return;
	// just to make sure we hit it.
	if (![sceneObject.collider doesCollideWithMesh:self]) return;
	// we did hit a rock! smash it!
	[(BBRock*)sceneObject smash];
	// now destroy ourself
	[[BBSceneController sharedSceneController] removeObjectFromScene:self];	
}

@end
