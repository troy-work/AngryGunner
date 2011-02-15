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
		wave1 = [CCSprite spriteWithFile:@"water1.png"];
		[wave1 setAnchorPoint:ccp(0,0)];
		[wave1 setOpacity:40];
		[wave1 setScaleX:2];
	    wave1.position = ccp(-120,0);
		
		wave2 = [CCSprite spriteWithFile:@"water2.png"];
		[wave2 setAnchorPoint:ccp(0,0)];
		[wave2 setOpacity:40];
		[wave2 setScaleX:3];
	    wave2.position = ccp(-80,0);
		
		[self addChild:wave1];
		[self addChild:wave2];
		[self schedule:@selector(step:)];
		x1 = -180;
		x2 = -280;
		y_1 = 15;
		y_2 = 0;
		count = 0;
		moveBy = 1;
	}	
	return self;		
}

-(void)step:(ccTime) dt{
	count += moveBy;
	if (count>100) {
		moveBy = -1;
	}
	if (count<-100) {
		moveBy = 1;
	}
	x1 += moveBy*dt*20;
	x2 -= moveBy*dt*20;
	y_1 -= moveBy*dt*2;
	y_2 += moveBy*dt*2;
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
