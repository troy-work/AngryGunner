//
//  Waves.m
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Waves.h"
#import "ccMacros.h"

@implementation Waves

CCSprite *wave1;
CCSprite *wave2;
float x1;
float x2;
float y_1;
float y_2;

float moveBy;
float count;

-(id)init{

	if( (self=[super init])) 
	{
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		float scaleFactor = 410/s.height;
		
		wave1 = [CCSprite spriteWithFile:@"water1.png"];
		[wave1 setAnchorPoint:ccp(.5,0)];
		[wave1 setOpacity:255];
		[wave1 setScaleY:scaleFactor];
		[wave1 setScaleX:3.6];
	    wave1.position = ccp(480,0);
		
		wave2 = [CCSprite spriteWithFile:@"water2.png"];
		[wave2 setAnchorPoint:ccp(.5,0)];
		[wave2 setOpacity:125];
		[wave2 setScaleY:scaleFactor];
		[wave2 setScaleX:3.6];
	    wave2.position = ccp(480,0);
		
		[self addChild:wave1];
		[self addChild:wave2];
		[self schedule:@selector(step:)];
		x1 = 240;
		x2 = 240;
		y_1 = 0;
		y_2 = 0;
		count = 0;
		moveBy = 1;
	}	
	return self;		
}

-(void)step:(ccTime) dt{
	count += moveBy;
	if (count>80) {
		moveBy = -1;
	}
	if (count<-80) {
		moveBy = 1;
	}
	x1 += moveBy*dt*40;
	x2 -= moveBy*dt*40;
	y_1 -= moveBy*dt*1;
	y_2 += moveBy*dt*1;
	[wave1 setPosition:ccp(x1,y_1)];
	[wave2 setPosition:ccp(x2,y_2)];
}

- (void)release {
	[super release];
}


-(void)dealloc
{
	[super dealloc];	
}

@end
