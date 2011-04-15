//
//  Start.m
//  AngryGunner
//
//  Created by Troy Cox on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Start.h"
#import "Game.h"
#import "Score.h"
#import "Sound.h"
#import "Help.h"
#import "Info.h"
#import "LevelData.h"
#import "AchievementManager.h"
#import "SimpleAudioEngine.h"

@implementation Start

CCLabelTTF *title;
CCLabelTTF *achievement;
CCMenu *multiplierMenu;
CCSprite *up;
CCSprite *down;
CCSprite *lock;

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
        if (![[LevelData sharedLevelData] shouldPlaySfx])
        {
            [[SimpleAudioEngine sharedEngine] setMute:TRUE];
        }
		
        
		CCSprite *bg = [CCSprite spriteWithFile:@"startscreen.jpg"];
		[bg setAnchorPoint:ccp(0,0)];
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
        
        up =[CCSprite spriteWithFile:@"up.png"];
        [up setAnchorPoint:ccp(.5,.5)];
        [up setPosition:ccp(440,238)];
        [up setOpacity:0];
        [self addChild:up];

        down =[CCSprite spriteWithFile:@"down.png"];
        [down setAnchorPoint:ccp(.5,.5)];
        [down setPosition:ccp(440,140)];
        [down setOpacity:0];
        [self addChild:down];

		CCMenuItem *score = [CCMenuItemFont itemFromString:@"VIEWHIGHSCORE" target:self selector:@selector(viewHighScore:)];
		CCMenuItem *start = [CCMenuItemFont itemFromString:@"|NEWGA|" target:self selector:@selector(startGame:)];
		CCMenuItem *help = [CCMenuItemFont itemFromString:@"HelpInfo" target:self selector:@selector(viewHelp:)];
		CCMenuItem *info = [CCMenuItemFont itemFromString:@"INF" target:self selector:@selector(viewInfo:)];
		CCMenuItem *speaker1 = [CCMenuItemFont itemFromString:@"SPP" target:self selector:@selector(toggleSpeaker:)];
		CCMenuItem *speaker2 = [CCMenuItemFont itemFromString:@"SPP" target:self selector:@selector(toggleSpeaker:)];
		
		
		
		score.position = ccp(0,85);
		start.position = ccp(180,85);
		help.position = ccp(295,85);
		info.position = ccp(310,26);
		speaker1.position = ccp(360,36);
		speaker2.position = ccp(360,16);
		
		
		CCMenu *menu = [CCMenu menuWithItems: score,start,help,info,speaker1,speaker2,nil];
		menu.position = ccp(90,0);
		[menu setOpacity:0];
		[self addChild:menu];

        CCMenuItem *lowerMultiplier = [CCMenuItemFont itemFromString:@"LOWER" target:self selector:@selector(lowerAchievement:)];
        CCMenuItem *raiseMultiplier = [CCMenuItemFont itemFromString:@"RAISE" target:self selector:@selector(raiseAchievement:)];
        [raiseMultiplier setPosition:ccp(0,102)];
        [lowerMultiplier setPosition:ccp(0,0)];
        multiplierMenu = [CCMenu menuWithItems:lowerMultiplier,raiseMultiplier, nil];
        [multiplierMenu setAnchorPoint:ccp(.5,0)];
        [multiplierMenu setPosition:ccp(450,135)];
        [multiplierMenu setOpacity:0];
        [self addChild:multiplierMenu];
        
        title =
        [CCLabelTTF labelWithString:[NSString stringWithFormat:@"\nMISSION: %@",[AchievementManager getTitleByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]] 
                         dimensions:CGSizeMake(385, 120) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:30.0f];
        [title setAnchorPoint:ccp(.5,.5)];
        [title setPosition:ccp(225,220)];
        [title setColor:ccc3(180,50,50)];
        [self addChild:title];
        
        
        achievement =
        [CCLabelTTF labelWithString:[AchievementManager getInstructionByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]
                         dimensions:CGSizeMake(385, 80) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:18.0f];
        [achievement setAnchorPoint:ccp(.5,.5)];
        [achievement setPosition:ccp(225,173)];
        [achievement setColor:ccc3(180,160,50)];
        [self addChild:achievement];
        
        lock = [CCSprite spriteWithFile:@"Lock.png"];
        [lock setAnchorPoint:ccp(.5,.5)];
        [lock setPosition:ccp(210,190)];
        [lock setScaleY:.65];
        [lock setScaleX:.8];
        [self addChild:lock];
        [self checkUpDown];
	}
	
	return self;
	
}

-(void)checkUpDown
{
    
    if ([[LevelData sharedLevelData]highestAchievement]>=[[LevelData sharedLevelData]currentMultiplier]-1)
    {
        [lock setOpacity:0];
    }
    else
    {
        [lock setOpacity:255];
    }
    
    if ([[LevelData sharedLevelData]currentMultiplier]<21)
    {
        [up setOpacity:255];
    }
    else
    {
        [up setOpacity:0];
    }
    
    if ([[LevelData sharedLevelData]currentMultiplier]>1)
    {
        [down setOpacity:255];
    }
    else
    {
        [down setOpacity:0];
    }
}

-(void)flash:(CCMenuItem*)menuItem
{
    CCSprite *flash = [CCSprite spriteWithFile:@"dpadburst.png"];
    [flash runAction:[CCSequence actions:[CCScaleBy actionWithDuration:.25 scale:2],
                      [CCCallFuncN actionWithTarget:self selector:@selector(killSprite:)],nil]];
    [flash setPosition:ccpAdd([menuItem position], [[menuItem parent] position])];
    [self addChild:flash];
}
-(void)redFlash:(CCMenuItem*)menuItem
{
    CCSprite *flash = [CCSprite spriteWithFile:@"dpadburst.png"];
    [flash runAction:[CCSequence actions:[CCScaleBy actionWithDuration:.25 scale:2],
                      [CCCallFuncN actionWithTarget:self selector:@selector(killSprite:)],nil]];
    [flash setPosition:ccpAdd([menuItem position], [[menuItem parent] position])];
    [flash setColor:ccc3(255, 0, 0)];
    [flash setOpacity:100];
    [self addChild:flash];
}

-(void)killSprite:(id)sender
{
	[[sender parent] removeChild:sender cleanup:FALSE];
}


-(void)updateAchievement
{
    [self checkUpDown];
    
    [title setString:[NSString stringWithFormat:@"\nMISSION: %@",[AchievementManager getTitleByMultiplier:[[LevelData sharedLevelData]currentMultiplier]]]];    
    
    [achievement setString:[AchievementManager getInstructionByMultiplier:
                            [[LevelData sharedLevelData]currentMultiplier]]];
}

-(void)raiseAchievement:(id)sender
{
    if ([[LevelData sharedLevelData]currentMultiplier]<21)
    {
        [self flash:sender];
        [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]+1 ];
        [LevelData saveState];
        [LevelData loadState];
        [self updateAchievement];
    }
    else
    {
        [self redFlash:sender];
    }
}

-(void)lowerAchievement:(id)sender
{
    if ([[LevelData sharedLevelData]currentMultiplier]>1)
    {
        [self flash:sender];
        [[LevelData sharedLevelData]setCurrentMultiplier:[[LevelData sharedLevelData]currentMultiplier]-1 ];
        [LevelData saveState];
        [LevelData loadState];
        [self updateAchievement];
    }
    else
    {
        [self redFlash:sender];
    }
}

-(void)viewHighScore:(id)sender
{	
	[self flash:sender];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                     [CCCallFunc actionWithTarget:self selector:@selector(replaceHighScore)],nil]];
}
-(void)replaceHighScore
{	
	[[CCDirector sharedDirector] replaceScene:[Score scene]];	
}

-(void)startGame:(id)sender
{	
    if ([[LevelData sharedLevelData]highestAchievement]>=[[LevelData sharedLevelData]currentMultiplier]-1)
    {
        [self flash:sender];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                         [CCCallFunc actionWithTarget:self selector:@selector(replaceGame)],nil]];
    }
    else
    {
        [self redFlash:sender];
    }
}
-(void)replaceGame
{	
	[[CCDirector sharedDirector] replaceScene:[Game scene]];	
}

-(void)viewHelp:(id)sender
{	
    [self flash:sender];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                     [CCCallFunc actionWithTarget:self selector:@selector(replaceHelp)],nil]];
}
-(void)replaceHelp
{	
    [[CCDirector sharedDirector] replaceScene:[Help scene]];	
}



-(void)viewInfo:(id)sender
{	
    [self flash:sender];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                     [CCCallFunc actionWithTarget:self selector:@selector(replaceInfo)],nil]];
}
-(void)replaceInfo
{	
    [[CCDirector sharedDirector] replaceScene:[Info scene]];	
}


-(void)toggleSpeaker:(id)sender
{	
    [self flash:sender];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                     [CCCallFunc actionWithTarget:self selector:@selector(replaceSound)],nil]];
}
-(void)replaceSound
{	
	[[CCDirector sharedDirector] replaceScene:[Sound scene]];	
}


-(void) onEnter
{
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

- (void)release {
//	NSLog(@"StartLayer retain count = %d", [self retainCount]);
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"startscreen.jpg"];    
	[super release];
}


-(void)dealloc
{
	//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
