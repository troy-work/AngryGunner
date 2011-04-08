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
#import "AchievementManager.h"

@implementation Start

CCLabelTTF *title;
CCLabelTTF *achievement;

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
        
        CCSprite *up =[CCSprite spriteWithFile:@"up.png"];
        [up setAnchorPoint:ccp(.5,.5)];
        [up setPosition:ccp(450,290)];
        [self addChild:up];

        CCSprite *down =[CCSprite spriteWithFile:@"down.png"];
        [down setAnchorPoint:ccp(.5,.5)];
        [down setPosition:ccp(450,215)];
        [self addChild:down];

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

        CCMenuItem *lowerMultiplier = [CCMenuItemFont itemFromString:@"Lower" target:self selector:@selector(lowerAchievement:)];
        CCMenuItem *raiseMultiplier = [CCMenuItemFont itemFromString:@"Raise" target:self selector:@selector(raiseAchievement:)];
        CCMenu *multiplierMenu = [CCMenu menuWithItems:lowerMultiplier,raiseMultiplier, nil];
        [lowerMultiplier setPosition:ccp(0,0)];
        [raiseMultiplier setPosition:ccp(0,75)];
        [multiplierMenu setAnchorPoint:ccp(.5,0)];
        [multiplierMenu setPosition:ccp(450,215)];
        [multiplierMenu setOpacity:0];
        [self addChild:multiplierMenu];
        
        title =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"\nMISSION: %@",[AchievementManager getTitleByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]] 
                         dimensions:CGSizeMake(410, 120) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:30.0f];
        [title setAnchorPoint:ccp(.5,.5)];
        [title setPosition:ccp(225,280)];
        [title setColor:ccc3(180,50,50)];
        [self addChild:title];
        
        
        achievement =
        [CCLabelTTF labelWithString:[AchievementManager getInstructionByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]
                         dimensions:CGSizeMake(410, 140) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:18.0f];
        [achievement setAnchorPoint:ccp(.5,.5)];
        [achievement setPosition:ccp(225,203)];
        [achievement setColor:ccc3(180,160,50)];
        [self addChild:achievement];
                
	}
	
	return self;
	
}

-(void)updateAchievement
{
    [title setString:[NSString stringWithFormat:@"\nMISSION: %@",[AchievementManager getTitleByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]]];    
    
    [achievement setString:[AchievementManager getInstructionByMultiplier:
                            [[LevelData sharedLevelData]currentMultiplier]]];
}

-(void)raiseAchievement:(id)sender
{
    [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]+1 ];
    [LevelData saveState];
    [LevelData loadState];
    [self updateAchievement];
}

-(void)lowerAchievement:(id)sender
{
    [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]-1 ];
    [LevelData saveState];
    [LevelData loadState];
    [self updateAchievement];
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
