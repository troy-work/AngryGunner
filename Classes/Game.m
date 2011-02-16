//
//  Game.m
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Waves.h"
#import "Joystick.h"

@implementation Game

Joystick *jstick;
float x;
float y;
CCLayer *bgLayer;
Waves *waves;

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Game *layer = [Game node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
		
		CCSprite *bg1 = [CCSprite spriteWithFile:@"backgroundleft.png"];
		[bg1 setAnchorPoint:ccp(1,0)];
		
	    bg1.position = ccp(241,0);

		CCSprite *bg2 = [CCSprite spriteWithFile:@"backgroundright.png"];
		[bg2 setAnchorPoint:ccp(0,0)];
		
	    bg2.position = ccp(240,0);
		
		bgLayer = [CCLayer node]; 
		
		[bgLayer addChild:bg1];
		[bgLayer addChild:bg2];
		[bgLayer setAnchorPoint:ccp(.5,0)];
		[self addChild:bgLayer];
		
		waves = [Waves node];
		[waves setAnchorPoint:ccp(.5,0)];
		[bgLayer addChild:waves];


		CCLayer* control = [CCLayer node];
		[control setAnchorPoint:ccp(0,0)];
		[control setPosition:ccp(60,60)];
		
		CCScene* jsBack = [CCSprite spriteWithFile:@"dpad.png"];
		[jsBack setAnchorPoint:ccp(.5,.5)];
		[jsBack setPosition:ccp(0,0)];
		//[control addChild:jsBack];
				
		CCSprite* jsThumb = [CCSprite spriteWithFile:@"dpadburst.png"];
		// jsThumb.scale = 0.80; // change thumb size if you like
		[jsThumb setAnchorPoint:ccp(.5,.5)];
		jstick = [Joystick joystickWithThumb: jsThumb andBackdrop: jsBack
												];
		[jstick setAnchorPoint:ccp(.5,.5)];
		jstick.position = ccp(0, 0);
		[control addChild: jstick];	
		
		[self addChild:control];
		
		[self schedule:@selector(step:)];
		x = 0;
		y = 0;
	}
	
	return self;	
}

-(void)step:(ccTime)dt{
	x = x - jstick.velocity.x*dt*400;
	y = y - jstick.velocity.y*dt*400;
	
	if (y>0) {
		y=0;
	}
	if (y<-1024+320) {
		y=-1024+320;
	}
	if (x>1024-480) {
		x=1024-480;
	}
	if (x<-1024+480) {
		x=-1024+480;
	}
	
	//[waves setPosition:ccp(-x,0)];
	
	[bgLayer setPosition:ccp(x,y)];
}

-(void) onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
	[jstick registerWithTouchDispatcher];
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
	[super onEnter];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{	
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}



-(void)startScene:(id)sender
{		
	//[[CCDirector sharedDirector] replaceScene:[StartScene node]];	
}


- (void)release {
	//	NSLog(@"StartLayer retain count = %d", [self retainCount]);
	[super release];
}


-(void)dealloc
{
	//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
