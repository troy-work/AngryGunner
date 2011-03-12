
#import "Joystick.h"
#import "CCNodeExtensions.h"

// The time it takes the thumb to spring back to center once the user lets go
#define kThumbSpringBackDuration 1.0

@interface Joystick (Private)
-(void) trackVelocity:(CGPoint) nodeTouchPoint;
-(void) resetVelocity;
@end


@implementation Joystick

@synthesize velocity, angularVelocity;

- (void)dealloc {
	thumbNode = nil;	// retained via child node
    [super dealloc];
}

-(id) initWithThumb: (CCNode*) aNode andSize: (CGSize) size {
	NSAssert(aNode, @"Thumb node must not be nil");
	if( (self = [super init]) ) {
		//[self setIsTouchEnabled:YES];
		isTracking = NO;
		velocity = CGPointZero;
		angularVelocity = AngularPointZero;

		// Add thumb node as a child and position it at the center
		// Must do following in this order: set thumb / set size / get anchor point
		thumbNode = aNode;
		[self addChild: thumbNode z: 1];
		self.contentSize = size;
		[thumbNode setPosition: self.anchorPoint];
	}
	return self;
}

+(id) joystickWithThumb: (CCNode*) aNode andSize: (CGSize) size {
	return [[self alloc] initWithThumb: aNode andSize: size];
}

-(id) initWithThumb: (CCNode*) aNode andBackdrop: (CCNode*) bgNode {
	NSAssert(bgNode, @"Backdrop node must not be nil");
	if( (self = [self initWithThumb: aNode andSize: bgNode.scaledSize]) ) {
		// Position the background node at the center and behind the thumb node 
		[bgNode setPosition: self.anchorPoint];
		[self addChild: bgNode z: 0];
	}
	return self;
}

+(id) joystickWithThumb: (CCNode*) thumbNode andBackdrop: (CCNode*) backgroundNode {
	return [[self alloc] initWithThumb: thumbNode andBackdrop: backgroundNode];
}

// Overridden to also set the limit of travel for the thumb node to
// keep it at all times within the bound of the Joystick contentSize.
-(void) setContentSize: (CGSize) newSize {
	[super setContentSize: newSize];
	travelLimit = ccpMult(ccpSub(ccpFromSize(self.contentSize), 
								 ccpFromSize(thumbNode.scaledSize)), 0.5);
}

#pragma mark Event handling

// Handle touch events one at a time
-(void) registerWithTouchDispatcher {
	self.isAccelerometerEnabled = YES;

	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate: self
										  priority: INT_MIN+2
										  swallowsTouches:TRUE];
	// Start with fresh state each time we register.
	// Certain transitions, such as dynamically overlaying the device camera
	// can cause abrupt breaks in targeted event state.
//	[self setIsTouchEnabled:YES];
//	[[CCTouchDispatcher sharedDispatcher] setDispatchEvents:TRUE];
	[self resetVelocity];
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
//	static float prevX=0, prevY=0;
//	
//#define kFilterFactor 0.05f
//	
//	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
//	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
//	
//	
//	//CGPoint v = ccp( -accelY, accelX);
//	if (prevX!=accelX||prevY!=accelY) {
//		prevX = accelX;
//		prevY = accelY;
//		float xx = accelY*150;
//		float yy = -accelX*150;
//		isTracking = YES;
//		[thumbNode stopAllActions];
//		[self trackVelocity: ccp(xx,yy)];
//	}
}


-(BOOL) ccTouchBegan: (UITouch *)touch withEvent: (UIEvent *)event {
	if(!isTracking) {
		CGSize cs = self.contentSize;
		float x = [self anchorPoint].x;
		float y = [self anchorPoint].y;
		CGPoint nodeTouchPoint = [self convertTouchToNodeSpace: touch];
			
		if (nodeTouchPoint.x<x+cs.width/2&&nodeTouchPoint.x>x-cs.width/2) {
			if (nodeTouchPoint.y<y+cs.height/2&&nodeTouchPoint.y>y-cs.height/2) {
				isTracking = YES;
				[thumbNode stopAllActions];
				[self trackVelocity: nodeTouchPoint];
				return YES;
			}
		}
	}	
	return NO;
}

-(void) ccTouchEnded: (UITouch *)touch withEvent: (UIEvent *)event {
	NSAssert(isTracking, @"Touch ended that was never begun");
	[self resetVelocity];
}

-(void) ccTouchCancelled: (UITouch *)touch withEvent: (UIEvent *)event {
	NSAssert(isTracking, @"Touch cancelled that was never begun");
	[self resetVelocity];
}

-(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
	NSAssert(isTracking, @"Touch moved that was never begun");
	[self trackVelocity: [self convertTouchToNodeSpace: touch]];
}

// Calculates and sets the velocity based on the specified touch point
// which is relative to the Joystick coordinate space. Updates the
// position of the thumb node to track the users movements, but constrained
// to the bounds of a circle inscribed within the Joystick contentSize.
-(void) trackVelocity:(CGPoint) nodeTouchPoint {
	CGPoint ankPtPx = self.anchorPoint;

	// Get the touch point relative to the joystick home (anchor point)
	CGPoint relPoint = ccpSub(nodeTouchPoint, ankPtPx);
	
	// Determine the raw unconstrained velocity vector
	CGPoint rawVelocity = CGPointMake(relPoint.x / travelLimit.x,
									  relPoint.y / travelLimit.y);

	// If necessary, normalize the velocity vector relative to the travel limits
	CGFloat rawVelLen = ccpLength(rawVelocity);
	velocity = rawVelocity;
//	velocity = ccpMult(velocity, 1.0f/rawVelLen);
    
    // If necessary, normalize the velocity vector relative to the travel limits
//	CGFloat rawVelLen = ccpLength(rawVelocity);
//	velocity = (rawVelLen <= 1.0) ? rawVelocity : ccpMult(rawVelocity, 1.0f/rawVelLen);    
    
	// Calculate the vector in angular coordinates
	// ccpToAngle returns counterclockwise positive relative to X-axis.
	// We want clockwise positive relative to the Y-axis.
	CGFloat angle = 90.0 - CC_RADIANS_TO_DEGREES(ccpToAngle(velocity));
	if(angle > 180.0) {
		angle -= 360.0;
	}
	angularVelocity.radius = ccpLength(velocity);
	angularVelocity.heading = angle;
	
	// Update the thumb's position, clamping it within the contentSize of the Joystick
	[thumbNode setPosition: ccpAdd(ccpCompMult(velocity, travelLimit), ankPtPx)];
}

// Immediately zeros the velocity vectors and then animates moving the thumb back
// to the center, using ElasticOut to give it a bounce as it centers.
-(void) resetVelocity {
	isTracking = NO;
	velocity = CGPointZero;
	angularVelocity = AngularPointZero;
	[thumbNode runAction: [CCEaseElasticOut actionWithAction:
								[CCMoveTo actionWithDuration: kThumbSpringBackDuration 
										  position: self.anchorPoint]]];
}

@end
