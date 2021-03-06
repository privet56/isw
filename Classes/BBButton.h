#import "BBSceneObject.h"

@interface BBButton : BBSceneObject {
	BOOL pressed;
	id target;
	SEL buttonDownAction;
	SEL buttonUpAction;
	CGRect screenRect;
}

@property (assign) id target;
@property (assign) SEL buttonDownAction;
@property (assign) SEL buttonUpAction;

- (void)awake;
- (void)handleTouches;
- (void)setNotPressedVertexes;
- (void)setPressedVertexes;
- (void)touchDown;
- (void)touchUp;
- (void)update;


@end
