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
CCLayer *friendsLayer;
CCLayer *gunner;
Waves *waves;
CCSprite *gun;
CCSprite *leftShield;
CCSprite *rightShield;
CCSprite *crossHair;

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
		
		
		friendsLayer = [CCLayer node];
		[friendsLayer setAnchorPoint:ccp(.5,0)];
		[self addChild:friendsLayer];
		
		CCSprite *destroyer2 = [CCSprite spriteWithFile:@"destroyer2.png"];
		[destroyer2 setAnchorPoint:ccp(.5,0)];
		[destroyer2 setPosition:ccp(-440,115)];
		[friendsLayer addChild:destroyer2];

		CCSprite *destroyer1 = [CCSprite spriteWithFile:@"destroyer1.png"];
		[destroyer1 setAnchorPoint:ccp(.5,0)];
		[destroyer1 setPosition:ccp(-240,150)];
		[friendsLayer addChild:destroyer1];

		CCSprite *smallcarrier = [CCSprite spriteWithFile:@"smallcarrier.png"];
		[smallcarrier setAnchorPoint:ccp(.5,0)];
		[smallcarrier setPosition:ccp(890,250)];
		[friendsLayer addChild:smallcarrier];		

		CCSprite *largecarrier = [CCSprite spriteWithFile:@"largecarrier.png"];
		[largecarrier setAnchorPoint:ccp(.5,0)];
		[largecarrier setPosition:ccp(820,200)];
		[friendsLayer addChild:largecarrier];
		
		CCSprite *destroyer3 = [CCSprite spriteWithFile:@"destroyer1.png"];
		[destroyer3 setAnchorPoint:ccp(.5,0)];
		[destroyer3 setPosition:ccp(840,110)];
		[friendsLayer addChild:destroyer3];

		gunner = [CCLayer node];
		[gunner setAnchorPoint:ccp(.5,0)];
		
		leftShield = [CCSprite spriteWithFile:@"shieldleft.png"];
		[leftShield setAnchorPoint:ccp(0,0)];
		[leftShield setPosition:ccp(10,0)];
		[leftShield setOpacity:45];
		[gunner addChild:leftShield];

		rightShield = [CCSprite spriteWithFile:@"shieldleft.png"];
		[rightShield setAnchorPoint:ccp(1,0)];
		[rightShield setPosition:ccp(470,0)];
		[rightShield setOpacity:45];
		[gunner addChild:rightShield];
		
		CCLayer* control = [CCLayer node];
		[control setAnchorPoint:ccp(0,0)];
		[control setPosition:ccp(65,85)];
		
		CCScene* jsBack = [CCSprite spriteWithFile:@"dpad.png"];
		[jsBack setAnchorPoint:ccp(.5,.5)];
		[jsBack setPosition:ccp(0,0)];
				
		CCSprite* jsThumb = [CCSprite spriteWithFile:@"dpadburst.png"];
		[jsThumb setAnchorPoint:ccp(.5,.5)];
		jstick = [Joystick joystickWithThumb: jsThumb andBackdrop: jsBack];
		[jstick setAnchorPoint:ccp(.5,.5)];
		[jstick setContentSize:CGSizeMake(150, 150)];
		jstick.position = ccp(0, 0);
		[control addChild: jstick];	
		
		[self addChild:control];
		
		
		gun = [CCSprite spriteWithFile:@"guns.png"];
		//[gun setVertexZ:100];
		[gun setAnchorPoint:ccp(.5, 0)];
		[gun setPosition:ccp(240,0)];
		[gunner addChild:gun];

		crossHair = [CCSprite spriteWithFile:@"crosshair.png"];
		[crossHair setAnchorPoint:ccp(.5,0)];
		[crossHair setPosition:ccp(240,0)];
		[crossHair setOpacity:45];
		[gunner addChild:crossHair];
		
		[self addChild:gunner];
		
		[self schedule:@selector(step:)];
		x = 0;
		y = 0;
	}
	
	return self;	
}

-(void)step:(ccTime)dt{
		
	float xx = jstick.velocity.x*jstick.velocity.x*jstick.velocity.x;
	float yy = jstick.velocity.y*jstick.velocity.y*jstick.velocity.y;
	
	x = x - xx*dt*800;
	y = y - yy*dt*800;
	float staticX = 0;
	
	if (y>0) {
		y=0;
	}
	if (y<-1024+320) {
		y=-1024+320;
	}
	if (x>1024-480) {
		staticX=1024-480;
	}
	if (x<-1024+480) {
		staticX=-1024+480;
	}

	if (staticX == 0) {
		[gunner setPosition:ccp(0,0)];
		//[waves setPosition:ccp(-x,0)];
		[friendsLayer setPosition:ccp(x,y)];
		[bgLayer setPosition:ccp(x,y)];		
	}else {
		if (x>1024-280) {
			x=1024-280;
		}
		if (x<-1024+280) {
			x=-1024+280;
		}
		
		//[waves setPosition:ccp(-x,0)];
		[friendsLayer setPosition:ccp(staticX,y)];
		[bgLayer setPosition:ccp(staticX,y)];
		[gunner setPosition:ccp(-x+staticX,0)];
	}

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
	return TRUE;
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
