//
//  Music.m
//  AngryGunner
//
//  Created by Troy Cox on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Music.h"
#import <Foundation/Foundation.h>
#import "LevelData.h"
#import "Music.h"
#import "Start.h"
#import "Sound.h"
#import <MediaPlayer/MPMediaPlaylist.h>
#import <MediaPlayer/MPMusicPlayerController.h>
#ifdef __APPLE__
#include "TargetConditionals.h"
#endif
#import "cocos2d.h"

@implementation Music

MPMusicPlayerController* appMusicPlayer;
CCLabelTTF *playingLabel;


#if (TARGET_IPHONE_SIMULATOR) 
bool isSimulator = TRUE;
#else
bool isSimulator=FALSE;
#endif

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Music *layer = [Music node];
	
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
		
		CCSprite *bg = [CCSprite spriteWithFile:@"musicscreen.jpg"];
		[bg setAnchorPoint:ccp(0,0)];		
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(startHome:)];
		
		
		home.position = ccp(10,295);
		
		CCMenu *menu = [CCMenu menuWithItems: home,nil];
		menu.position = ccp(0,0);
		[menu setOpacity:0];
		[self addChild:menu];
		
		
		MPMediaQuery *myPlaylistsQuery = [MPMediaQuery playlistsQuery];
		NSArray *playlists = [myPlaylistsQuery collections];
		
		if ([playlists count]>0)
		{
			CCMenu *menuList =[CCMenu menuWithItems:nil];
			[menuList setAnchorPoint:ccp(.5,.5)];
			[menuList setPosition:ccp(240,270)];
			int i = 1;
			int x = 0;
			int y = 0;
			
			for (MPMediaPlaylist *playlist in playlists) {
				//				NSLog (@"%@", [playlist valueForProperty: MPMediaPlaylistPropertyName]);
				NSString *parm = [playlist valueForProperty: MPMediaPlaylistPropertyName];
				[CCMenuItemFont setFontName:@"321impact.ttf"];
				CCMenuItem *item = [CCMenuItemFont itemFromString:parm target:self selector:@selector(playMusic:)];
				
                
				[item setUserData:parm];
				[item setAnchorPoint:ccp(.5,.5)];
				[item setPosition:ccp(x , y - i * 30)];
				[menuList addChild:item z:10 tag:i];
				
				i++;
				if (i>8) {
					break;
				}
				//				NSArray *songs = [playlist items];
				//				for (MPMediaItem *song in songs) {
				//					NSString *songTitle =
				//					[song valueForProperty: MPMediaItemPropertyTitle];
				//					NSLog (@"\t\t%@", songTitle);
				//				}
			}
            [menuList setColor:ccc3(180, 100, 50)];
			[self addChild:menuList];
			
			if ([appMusicPlayer nowPlayingItem]) {								
				playingLabel =
				[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Currently Playing:%@",[[appMusicPlayer nowPlayingItem]valueForProperty:MPMediaItemPropertyTitle]] 
								 dimensions:CGSizeMake(470, 30) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:20.0f];
				[playingLabel setAnchorPoint:ccp(.5,.5)];
				[playingLabel setPosition:ccp(240,10)];
				[playingLabel setColor:ccc3(0,0,0)];
				[self addChild:playingLabel];
				
			}				
			
		}else {
			
			if ([[[MPMediaQuery songsQuery] items] count] > 0) {
				// The user has songs in his or her library.
				[self playLast];
				
				CCLabelTTF *message =
				[CCLabelTTF labelWithString:@"\nIf you group the music in your ipod player into a play list, you can choose it here." 
								 dimensions:CGSizeMake(300, 150) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:30.0f];
				[message setAnchorPoint:ccp(.5,.5)];
				[message setPosition:ccp(240,160)];
				[message setColor:ccc3(180,100,50)];
				[self addChild:message];
			}else {
				CCLabelTTF *message =
				[CCLabelTTF labelWithString:@"\nThere is no music in your iPod. You can download music from iTunes!" 
								 dimensions:CGSizeMake(300, 150) alignment:CCTextAlignmentLeft  fontName:@"321impact.ttf" fontSize:30.0f];
				[message setAnchorPoint:ccp(.5,.5)];
				[message setPosition:ccp(240,160)];
				[message setColor:ccc3(180,100,50)];
				[self addChild:message];
				
			}
			
		}
		
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

-(void)killSprite:(id)sender
{
	[[sender parent] removeChild:sender cleanup:FALSE];
}

-(void)startHome:(id)sender
{	
    [self flash:sender];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.25],
                     [CCCallFuncN actionWithTarget:self selector:@selector(goHome:)],nil]];
}

-(void)goHome:(id)sender
{
	[[CCDirector sharedDirector] replaceScene:[Start node]];	
}

-(void)playingItemChanged
{
	[self removeChild:playingLabel cleanup:TRUE];
	if ([appMusicPlayer nowPlayingItem]) {
		playingLabel =
		[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Currently Playing:%@",[[appMusicPlayer nowPlayingItem]valueForProperty:MPMediaItemPropertyTitle]] 
						 dimensions:CGSizeMake(470, 30) alignment:CCTextAlignmentLeft  fontName:@"Arial" fontSize:20.0f];
		[playingLabel setAnchorPoint:ccp(.5,.5)];
		[playingLabel setPosition:ccp(240,10)];
		[playingLabel setColor:ccc3(0,0,0)];
		[self addChild:playingLabel];
		
	}				
	
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
    
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"musicscreen.jpg"];
    
	[super release];
}

-(void)playMusic:(CCMenuItem *)sender
{
	
//	NSLog(@"%@",sender.userData); 
	
	[appMusicPlayer setShuffleMode: MPMusicShuffleModeSongs];
	[appMusicPlayer setRepeatMode: MPMusicRepeatModeAll];	
	
	MPMediaQuery *myPlaylistsQuery = [MPMediaQuery playlistsQuery];
	
	
	MPMediaPropertyPredicate *playlistNamePredicate =
	[MPMediaPropertyPredicate predicateWithValue: sender.userData
									 forProperty: MPMediaPlaylistPropertyName];
	
	[myPlaylistsQuery addFilterPredicate:playlistNamePredicate];
	
	[appMusicPlayer setQueueWithQuery: myPlaylistsQuery];
	[appMusicPlayer play];
	[self playingItemChanged];
	[[CCDirector sharedDirector] replaceScene:[Sound scene]];
}

-(void)playLast
{		
	[appMusicPlayer setShuffleMode: MPMusicShuffleModeSongs];
	[appMusicPlayer setRepeatMode: MPMusicRepeatModeAll];	
	if (![appMusicPlayer nowPlayingItem]) {
		[appMusicPlayer skipToPreviousItem];	
		[appMusicPlayer play];
	}
	[self playingItemChanged];
	
}


@end
