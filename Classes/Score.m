//
//  Score.m
//  AngryGunner
//
//  Created by Troy Cox on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Score.h"
#import "Start.h"
#import "Game.h"
#import "cocos2d.h"
#import "Appirater.h"
#import <UIKit/UIDevice.h>
#import "GameCenterManager.h"
#import "LevelData.h"
#import "AchievementManager.h"

@implementation Score

int score;
int highScore;
UIViewController *tempVC;
CCSprite *gameCenterButton;


+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Score *layer = [Score node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id)init
{
	if( (self=[super init])) 
	{
		[LevelData saveState];
		score = [[LevelData sharedLevelData] score];
		highScore = [[LevelData sharedLevelData] highScore];
		[[LevelData sharedLevelData] setScore:0];
		if (score>highScore) {
			[[LevelData sharedLevelData] setHighScore:score];
		}
		[LevelData saveState];
		
		bool canUseGameCenter = [GameCenterManager isGameCenterAvailable];
		bool usingGameCenter = [[LevelData sharedLevelData]useGameCenter];
		
		if (usingGameCenter) {
			[self reportScore];
		}
		
		if(score>50000){
			[Appirater userDidSignificantEvent:YES]; 	
		}
		
		CCSprite *bg = [CCSprite spriteWithFile:@"gameoverscreen.jpg"];
		[bg setAnchorPoint:ccp(0,0)];
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		CCMenuItem *gameCenter;
		if (canUseGameCenter) {
			gameCenterButton = [CCSprite spriteWithFile:@"gamecenter.png"];
			[gameCenterButton setAnchorPoint:ccp(.5,.5)];
			[gameCenterButton setPosition:ccp(340,184)];
			[self addChild:gameCenterButton];
			gameCenter = [CCMenuItemFont itemFromString:@"GAMECENTERLEADER" target:self selector:@selector(menuItemLeaderBoardClicked:)];
			gameCenter.position = ccp(340,184);
		}
		
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(goHome:)];
		CCMenuItem *start = [CCMenuItemFont itemFromString:@"NEWGAME" target:self selector:@selector(startGame:)];
		
		home.position = ccp(10,295);
		start.position = ccp(240,40);
		
		CCMenu *menu = [CCMenu menuWithItems: home,start,nil];
		if (canUseGameCenter) {
			[menu addChild:gameCenter z:0 tag:0];
		}
		menu.position = ccp(0,0);
		[menu setOpacity:0];
		[self addChild:menu];
		
		CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:
								[NSString stringWithFormat:@"%i",score]									   
													  fntFile:@"321impact.fnt"];
		
		[scoreLabel setAnchorPoint:ccp(.5,.5)];
		[scoreLabel setScale:1];
		[scoreLabel setColor:ccc3(50,80,100)];
		[scoreLabel setPosition:ccp(144,104)];
		[self addChild:scoreLabel];
		
		
		CCLabelBMFont *highScoreLabel = [CCLabelBMFont labelWithString:
									 [NSString stringWithFormat:@"%i",highScore]									   
														   fntFile:@"321impact.fnt"];
		
		[highScoreLabel setAnchorPoint:ccp(.5,.5)];
		[highScoreLabel setScale:1];
		[highScoreLabel setColor:ccc3(50,80,100)];
		[highScoreLabel setPosition:ccp(336,104)];
		[self addChild:highScoreLabel];
		
	}
	
	return self;
	
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

-(void)killSprite:(id)sender
{
	[[sender parent] removeChild:sender cleanup:TRUE];
}

-(void)replaceGame
{	
	[[CCDirector sharedDirector] replaceScene:[Game scene]];	
}

-(void)goHome:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[Start node]];	
}

- (void) authenticateLocalPlayer
{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil)
		{
			// Insert code here to handle a successful authentication.
			NSLog(@"Game Center: Player Authenticated!");
			[[LevelData sharedLevelData]setUseGameCenter:TRUE];
			[self reportScore];
			[self menuItemLeaderBoardClicked:self];
		}
		else
		{
			// Your application can process the error parameter to report the error to the player.
			NSLog(@"Game Center: Authentication Failed!");
			[[LevelData sharedLevelData]setUseGameCenter:FALSE];
		}
		[LevelData saveState];
		[LevelData loadState];
	}];
}


-(void) menuItemLeaderBoardClicked:(id)sender
{
	[gameCenterButton setScale:.5];
	[gameCenterButton runAction:[CCScaleTo actionWithDuration:1.0 scale:1]];
	
	if (![[LevelData sharedLevelData] useGameCenter]) {
		[self authenticateLocalPlayer];
	}
	if ([[LevelData sharedLevelData]useGameCenter]) {
		tempVC = [[UIViewController alloc]init];
		
		GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
		
		if (leaderboardController != nil)
		{
			leaderboardController.leaderboardDelegate = self;
			
			[[[CCDirector sharedDirector] openGLView] addSubview:tempVC.view];
			[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];		
			
			[tempVC presentModalViewController:leaderboardController animated: YES];
		}
	}
	
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{	 
	[viewController.view setHidden:TRUE];
	[viewController release];
	[tempVC release];
    [self achievementBoard];
}

-(void) achievementBoard
{	
	if (![[LevelData sharedLevelData] useGameCenter]) {
		[self authenticateLocalPlayer];
	}
	if ([[LevelData sharedLevelData]useGameCenter]) {
		tempVC = [[UIViewController alloc]init];
		
		GKAchievementViewController *acheivementController = [[GKAchievementViewController alloc] init];
		
		if (acheivementController != nil)
		{
			acheivementController.achievementDelegate = self;
			
			[[[CCDirector sharedDirector] openGLView] addSubview:tempVC.view];
			[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];		
			
			[tempVC presentModalViewController:acheivementController animated: YES];
		}
	}	
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{	 
	[viewController.view setHidden:TRUE];
    //    [viewController dismissModalViewControllerAnimated:YES];
	[viewController release];
	[tempVC release];
}

- (void) reportScore 
{
	GameCenterManager *g = [[GameCenterManager alloc]init];
	[g reportScore:score forCategory:@"angrygunner"];
    [g submitAchievement:[NSString stringWithFormat:@"%i", [[LevelData sharedLevelData]currentMultiplier]] percentComplete:100] ;
	[g release];
}

-(UIViewController*) getRootViewController 
{ 
	return [ UIApplication sharedApplication] .keyWindow.rootViewController; 
} 

-(void) release
{
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"gameoverscreen.jpg"];

    [super release];
}

- (void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
