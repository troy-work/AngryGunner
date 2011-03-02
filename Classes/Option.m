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
CGPoint diffPosition;
CGPoint torpPosition;
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
		
		
		diffPosition = ccp(210,210);
		torpPosition = ccp(210,132);

		
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
		CCMenuItem *difficult = [CCMenuItemFont itemFromString:@"DIFFICULTY" target:self selector:@selector(goDifficulty:)];
		CCMenuItem *difficult2 = [CCMenuItemFont itemFromString:@"DIFFICULTY" target:self selector:@selector(goDifficulty:)];
		CCMenuItem *difficultOff = [CCMenuItemFont itemFromString:@"DIFFICULTY" target:self selector:@selector(goDifficultyOff:)];
		CCMenuItem *difficult2Off = [CCMenuItemFont itemFromString:@"DIFFICULTY" target:self selector:@selector(goDifficultyOff:)];
		CCMenuItem *torp = [CCMenuItemFont itemFromString:@"TORPEDOS" target:self selector:@selector(goTorpedo:)];
		CCMenuItem *torp2 = [CCMenuItemFont itemFromString:@"TORPEDOS" target:self selector:@selector(goTorpedo:)];
		CCMenuItem *torpOff = [CCMenuItemFont itemFromString:@"TORPEDOS" target:self selector:@selector(goTorpedoOff:)];
		CCMenuItem *torp2Off = [CCMenuItemFont itemFromString:@"TORPEDOS" target:self selector:@selector(goTorpedoOff:)];
		
		
		home.position = ccp(10,295);
		difficult.position = ccp(160,189);
		difficult2.position = ccp(160,213);
		difficultOff.position = ccp(320,189);
		difficult2Off.position = ccp(320,213);
		torp.position = ccp(160,107);
		torp2.position = ccp(160,132);
		torpOff.position = ccp(320,107);
		torp2Off.position = ccp(320,132);
		
		
		CCMenu *menu = [CCMenu menuWithItems: home,difficult,difficult2,torp,torp2,difficultOff,difficult2Off,torpOff,torp2Off,nil];
		
		menu.position = ccp(0,0);
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
	[difficulty setPosition:diffPosition];
		difficulty.opacity = 255;
}

-(void)placeTorpedo
{
	[torpedo setOpacity:0];
	[torpedo setPosition:torpPosition];
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
	diffPosition = ccp(210,210);
	[self placeDifficulty]; 
	[LevelData saveState];
}
-(void)goDifficultyOff:(id)sender
{
	//	[[LevelData sharedLevelData] setBackGround:@"DesertSky.jpg"];
	diffPosition = ccp(360,210);
	[self placeDifficulty]; 
	[LevelData saveState];
}
-(void)goTorpedo:(id)sender
{
//	[[LevelData sharedLevelData] setBackGround:@"MountainSky.jpg"];
	torpPosition = ccp(210,132);
	[self placeTorpedo]; 
	[LevelData saveState];
}
-(void)goTorpedoOff:(id)sender
{
	//	[[LevelData sharedLevelData] setBackGround:@"MountainSky.jpg"];
	torpPosition = ccp(360,132);
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
