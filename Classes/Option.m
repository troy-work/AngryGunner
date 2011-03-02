//
//  Option.m
//  AngryGunner
//
//  Created by Troy Cox on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Option.h"
#import "LevelData.h"
#import "Start.h"

@implementation Option

CCSprite *difficulty;
CCSprite *redCheck;
CCSprite *torpedo;

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Option *layer = [Option node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
		[LevelData loadState];
		[LevelData sharedLevelData];
		
		CCSprite *bg = [CCSprite spriteWithFile:@"optionsscreen.png"];
		[bg setAnchorPoint:ccp(0,0)];
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		difficulty = [CCSprite spriteWithFile:@"GreenCheck.png"];
		[difficulty setAnchorPoint:ccp(.5,.5)];
		[difficulty setOpacity:0];
		[self addChild:difficulty];
		
		torpedo = [CCSprite spriteWithFile:@"GreenCheck.png"];
		[torpedo setAnchorPoint:ccp(.5,.5)];
		[torpedo setOpacity:0];
		[self addChild:torpedo];
		
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(goHome:)];
		CCMenuItem *difficult = [CCMenuItemFont itemFromString:@"DESERT" target:self selector:@selector(goDifficulty:)];
		CCMenuItem *torp = [CCMenuItemFont itemFromString:@"MOUNTA" target:self selector:@selector(goTorpedo:)];
		CCMenuItem *difficult2 = [CCMenuItemFont itemFromString:@"DESERT" target:self selector:@selector(goDifficulty:)];
		CCMenuItem *torp2 = [CCMenuItemFont itemFromString:@"MOUNTA" target:self selector:@selector(goTorpedo:)];
//		CCMenuItem *playerBlue = [CCMenuItemFont itemFromString:@"BLUEPLANE" target:self selector:@selector(bluePlane)];
//		CCMenuItem *playerGreen = [CCMenuItemFont itemFromString:@"BROWNPLANE" target:self selector:@selector(greenPlane)];
//		CCMenuItem *playerWhite = [CCMenuItemFont itemFromString:@"PINKPLANE" target:self selector:@selector(whitePlane)];
		
		
		home.position = ccp(0,0);
		difficult.position = ccp(280,-180);
		torp.position = ccp(390,-180);
		difficult2.position = ccp(280,-210);
		torp2.position = ccp(390,-210);
		
		
		CCMenu *menu = [CCMenu menuWithItems: home,difficult,difficult2,torp,torp2,nil];
		
		menu.position = ccp(10,295);
		menu.opacity=0;
		[self addChild:menu];
		[self placeDifficulty]; 
		[self placeTorpedo];
	}
	
	return self;
	
}

-(void)placeDifficulty
{
	
	difficulty.opacity = 0;
		difficulty.position = ccp(120,115);
		difficulty.opacity = 255;
}

-(void)placeTorpedo
{
	[torpedo setOpacity:0];
	
		torpedo.position = ccp(120,210);
		[torpedo setOpacity:255];
	
}

-(void)goHome:(id)sender
{			
//	[[LevelData sharedLevelData]setShowInstruction:TRUE];
	[LevelData saveState];
	[[CCDirector sharedDirector] replaceScene:[Start node]];	
}

-(void)goDifficulty:(id)sender
{
//	[[LevelData sharedLevelData] setBackGround:@"DesertSky.jpg"];
	[self placeDifficulty]; 
	[LevelData saveState];
}
-(void)goTorpedo:(id)sender
{
//	[[LevelData sharedLevelData] setBackGround:@"MountainSky.jpg"];
	[self placeTorpedo]; 
	[LevelData saveState];
}


-(void) onEnter
{
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

- (void)release {
	[super release];
}


-(void)dealloc
{
	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
