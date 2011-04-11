//
//  Sound.m
//  AngryGunner
//
//  Created by Troy Cox on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <MediaPlayer/MPMediaPlaylist.h>
#import <MediaPlayer/MPMusicPlayerController.h>
#import "Sound.h"
#import "Cocos2d.h"
#import "CCTransition.h"
#import "Start.h"
#import "Music.h"
#import "LevelData.h"
#import "SimpleAudioEngine.h"

@implementation Sound

CCSprite *greenSfxCheck;
MPMusicPlayerController* appMusicPlayer;

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Sound *layer = [Sound node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id)init
{
	if( (self=[super init])) 
	{
		
		appMusicPlayer = [MPMusicPlayerController iPodMusicPlayer];
		
		//********************************
		
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		
		[notificationCenter
		 addObserver: self
		 selector:    @selector (handle_NowPlayingItemChanged:)
		 name:        MPMusicPlayerControllerNowPlayingItemDidChangeNotification
		 object:      appMusicPlayer];
		
		[notificationCenter
		 addObserver: self
		 selector:    @selector (handle_PlaybackStateChanged:)
		 name:        MPMusicPlayerControllerPlaybackStateDidChangeNotification
		 object:      appMusicPlayer];
		
		[appMusicPlayer beginGeneratingPlaybackNotifications];		
		
		//********************************		
		
		CCSprite *bg = [CCSprite spriteWithFile:@"soundscreen.png"];
		[bg setAnchorPoint:ccp(0,0)];		
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		greenSfxCheck = [CCSprite spriteWithFile:@"GreenCheck.png"];
		[greenSfxCheck setAnchorPoint:ccp(.5,.5)];
		[greenSfxCheck setOpacity:0];
		[self addChild:greenSfxCheck];
		
		
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(goHome:)];
		CCMenuItem *sfx = [CCMenuItemFont itemFromString:@"SOUNDFX" target:self selector:@selector(playSfx:)];
		CCMenuItem *offSfx = [CCMenuItemFont itemFromString:@"OFFSFXX" target:self selector:@selector(stopSfx:)];
		CCMenuItem *music = [CCMenuItemFont itemFromString:@"MUSICPLAY" target:self selector:@selector(playMusic:)];
		CCMenuItem *offMusic = [CCMenuItemFont itemFromString:@"OFFMUSIC" target:self selector:@selector(stopMusic:)];
		
		home.position = ccp(10,295);
		sfx.position = ccp(160,120);
		offSfx.position = ccp(300,120);
		music.position = ccp(160,200);
		offMusic.position = ccp(300,200);
		
		CCMenu *menu = [CCMenu menuWithItems: home,sfx,offSfx,music,offMusic,nil];
		menu.position = ccp(0,0);
		[menu setOpacity:0];
		[self addChild:menu];
		[self placeChecks];
	}
	
	return self;
	
}


-(void)placeChecks
{
	
	greenSfxCheck.opacity = 0;
	
	int doFx = [[LevelData sharedLevelData] shouldPlaySfx];
	
	if (doFx == TRUE){
		greenSfxCheck.position = ccp(160,120);
		greenSfxCheck.opacity = 255;
	}else{
		greenSfxCheck.position = ccp(300,120);
		greenSfxCheck.opacity = 255;
	}
}

-(void)stopMusic:(id)sender
{
	[appMusicPlayer stop];
	
	//	[[MPMusicPlayerController applicationMusicPlayer] stop];
	
}

-(void)stopSfx:(id)sender
{
	[[LevelData sharedLevelData] setShouldPlaySfx:FALSE];
    [[SimpleAudioEngine sharedEngine] setMute:TRUE];
	[LevelData saveState];
	[self placeChecks];
}

-(void)playSfx:(id)sender
{
	[[LevelData sharedLevelData] setShouldPlaySfx:TRUE ];
    [[SimpleAudioEngine sharedEngine] setMute:FALSE];
	[LevelData saveState];
	[self placeChecks];
}

-(void)playMusic:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[Music scene]];
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
	//***************************
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name:           MPMusicPlayerControllerNowPlayingItemDidChangeNotification
	 object:         appMusicPlayer];
	
	[[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name:           MPMusicPlayerControllerPlaybackStateDidChangeNotification
	 object:         appMusicPlayer];
	
	[appMusicPlayer endGeneratingPlaybackNotifications];
	//*****************************	
	[super release];
}


-(void)dealloc
{
	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}

@end
