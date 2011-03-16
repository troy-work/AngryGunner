//
//  Achievement.m
//  AngryGunner
//
//  Created by Troy Cox on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Achievement.h"
#import "Start.h"
#import "LevelData.h"
#import "AchievementManager.h"

@implementation Achievement

CCSprite *greenSfxCheck;

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Achievement *layer = [Achievement node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id)init
{
	if( (self=[super init])) 
	{				
		CCSprite *bg = [CCSprite spriteWithFile:@"levelachievements.jpg"];
		[bg setAnchorPoint:ccp(0,0)];		
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
				
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(goHome:)];
		
		home.position = ccp(10,295);
		
		CCMenu *menu = [CCMenu menuWithItems: home,nil];
		menu.position = ccp(0,0);
		[menu setOpacity:0];
		[self addChild:menu];

        CCLabelTTF *title =
        [CCLabelTTF labelWithString:[AchievementManager getTitleByMultiplier:[[LevelData sharedLevelData]currentMultiplier]] 
                         dimensions:CGSizeMake(420, 120) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:30.0f];
        [title setAnchorPoint:ccp(.5,.5)];
        [title setPosition:ccp(240,160)];
        [title setColor:ccc3(180,50,50)];
        [self addChild:title];
        
        
        CCLabelTTF *achievement =
        [CCLabelTTF labelWithString:[AchievementManager getInstructionByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]
                         dimensions:CGSizeMake(420, 140) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:18.0f];
        [achievement setAnchorPoint:ccp(.5,.5)];
        [achievement setPosition:ccp(240,120)];
        [achievement setColor:ccc3(180,160,50)];
        [self addChild:achievement];

        CCLabelTTF *multiplier =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"YOU ARE AT: %iX", [[LevelData sharedLevelData]currentMultiplier]] 
                         dimensions:CGSizeMake(420, 120) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:44.0f];
        [multiplier setAnchorPoint:ccp(.5,.5)];
        [multiplier setPosition:ccp(240,5)];
        [multiplier setColor:ccc3(180,50,50)];
        [self addChild:multiplier];
}
	
	return self;	
}

-(void)goHome:(id)sender
{	
	[[CCDirector sharedDirector] replaceScene:[Start scene]];	
}

-(void) onEnter
{
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

-(void)release
{
	[super release];
}


-(void)dealloc
{
//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}

@end
