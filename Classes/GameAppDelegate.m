//
//  GameAppDelegate.m
//  Cocos2dManager
//
//  Created by Troy Cox on 1/8/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "GameAppDelegate.h"


@interface GameAppDelegate (PrivateMethods)

@end

@implementation GameAppDelegate

#pragma mark GameDelegate Methods
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	[application setIdleTimerDisabled:YES];
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
	//	[CCDirector setDirectorType:kCCDirectorTypeNSTimer];
	[CCDirector setDirectorType:CCDirectorTypeThreadMainLoop];
	
	CCDirector *director = [CCDirector sharedDirector];
	
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	[director setDisplayFPS:NO];
	[director setAnimationInterval:1.0/60];
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565
								   depthFormat:0 /* GL_DEPTH_COMPONENT24_OES */
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0
						];
	[director setOpenGLView:glView];
	[window addSubview:glView];																
	[window makeKeyAndVisible];		
	
	//[window setUserInteractionEnabled:YES];
	//[window setMultipleTouchEnabled:YES];
	
	[director setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	[director setDisplayFPS:YES];
	
	CCScene *game = [CCScene node];

//	GameScene *layer = [GameScene node];

//	[game addChild:layer];
//	[director runWithScene:game];
}

- (void)applicationWillTerminate:(UIApplication*)application
{
	[[CCDirector sharedDirector] end];
}

-(void)dealloc
{
	[window release];
	[super dealloc];
}

-(void) applicationWillResignActive:(UIApplication *)application
{
	[[CCDirector sharedDirector] pause];
}

-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCTextureCache sharedTextureCache] removeAllTextures];
}

@end
