//
//  Start.m
//  AngryGunner
//
//  Created by Troy Cox on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Start.h"
#import "Game.h"
#import "Achievement.h"
#import "Sound.h"
#import "LevelData.h"

@implementation Start

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Start *layer = [Start node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id)init
{
	if( (self=[super init])) 
	{
		
		CCSprite *bg = [CCSprite spriteWithFile:@"startscreen.jpg"];
		[bg setAnchorPoint:ccp(0,0)];
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		CCMenuItem *options = [CCMenuItemFont itemFromString:@"ACHIEVEMENTS" target:self selector:@selector(viewAchievement:)];
		CCMenuItem *start = [CCMenuItemFont itemFromString:@"|NewGa|" target:self selector:@selector(startGame:)];
		CCMenuItem *help = [CCMenuItemFont itemFromString:@"HelpInfo" target:self selector:@selector(viewHelp:)];
		CCMenuItem *info = [CCMenuItemFont itemFromString:@"INF" target:self selector:@selector(viewInfo:)];
		CCMenuItem *speaker1 = [CCMenuItemFont itemFromString:@"SPP" target:self selector:@selector(toggleSpeaker:)];
		CCMenuItem *speaker2 = [CCMenuItemFont itemFromString:@"SPP" target:self selector:@selector(toggleSpeaker:)];
		
		
		
		options.position = ccp(0,85);
		start.position = ccp(180,85);
		help.position = ccp(295,85);
		info.position = ccp(310,26);
		speaker1.position = ccp(360,36);
		speaker2.position = ccp(360,16);
		
		
		CCMenu *menu = [CCMenu menuWithItems: options,start,help,info,speaker1,speaker2,nil];
		menu.position = ccp(90,0);
		[menu setOpacity:0];
		[self addChild:menu];

        CCMenuItem *lowerMultiplier = [CCMenuItemFont itemFromString:@"Lower Achievement for Testing" target:self selector:@selector(lowerAchievement:)];
        CCMenuItem *raiseMultiplier = [CCMenuItemFont itemFromString:@"Raise Achievement for Testing" target:self selector:@selector(raiseAchievement:)];
        CCMenu *multiplierMenu = [CCMenu menuWithItems:lowerMultiplier,raiseMultiplier, nil];
        [lowerMultiplier setPosition:ccp(0,0)];
        [raiseMultiplier setPosition:ccp(0,40)];
        [multiplierMenu setAnchorPoint:ccp(.5,0)];
        [multiplierMenu setPosition:ccp(240,250)];
        [self addChild:multiplierMenu];
        
	}
	
	return self;
	
}

-(void)raiseAchievement:(id)sender
{
    [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]+1 ];
    [LevelData saveState];
    [LevelData loadState];
}

-(void)lowerAchievement:(id)sender
{
    [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]-1 ];
    [LevelData saveState];
    [LevelData loadState];
}

-(void)viewAchievement:(id)sender
{	
	[[CCDirector sharedDirector] replaceScene:[Achievement scene]];	
}

-(void)startGame:(id)sender
{	
	
	[[CCDirector sharedDirector] replaceScene:[Game scene]];	
}

-(void)viewHelp:(id)sender
{	
//	[[CCDirector sharedDirector] replaceScene:[Help scene]];	
}

-(void)viewInfo:(id)sender
{	
//	[[CCDirector sharedDirector] replaceScene:[Info scene]];	
}

-(void)toggleSpeaker:(id)sender
{	
	[[CCDirector sharedDirector] replaceScene:[Sound scene]];	
}


-(void) onEnter
{
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

- (void)release {
	NSLog(@"StartLayer retain count = %d", [self retainCount]);
	[super release];
}


-(void)dealloc
{
	//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
