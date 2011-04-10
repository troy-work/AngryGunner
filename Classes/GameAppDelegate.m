//
//  GameAppDelegate.m
//  Cocos2dManager
//
//  Created by Troy Cox on 1/8/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "GameAppDelegate.h"
#import "Splash.h"
#import "Game.h"
#import "Appirater.h"
#import <GameKit/GameKit.h>
#import "LevelData.h"
#import "GameCenterManager.h"
#import "CDAudioManager.h"

@interface GameAppDelegate (PrivateMethods)

@end

@implementation GameAppDelegate

#pragma mark GameDelegate Methods


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	[application setIdleTimerDisabled:YES];	
	
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	[window setUserInteractionEnabled:YES];
//	[window setMultipleTouchEnabled:YES];
	
	//if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
	[CCDirector setDirectorType:kCCDirectorTypeNSTimer];	
	//[CCDirector setDirectorType:CCDirectorTypeThreadMainLoop];
	
	// before creating any layer, set the landscape mode
	CCDirector *director = [CCDirector sharedDirector];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];	
	
	[director setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	[director setDisplayFPS:NO];
	[director setAnimationInterval:1.0/60];

	
	// Create an EAGLView with a RGB8 color buffer, and a depth buffer of 24-bits
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGBA8                // RGBA8 color buffer
								   depthFormat:GL_DEPTH_COMPONENT24_OES   // 24-bit depth buffer
							preserveBackbuffer:NO
									sharegroup:nil //for sharing OpenGL contexts between threads
								 multiSampling:NO //YES to enable it
							   numberOfSamples:0 //can be 1 - 4 if multiSampling=YES
						];
	
	[glView setMultipleTouchEnabled:YES];
	// attach the openglView to the director
	[director setOpenGLView:glView];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

    
	CDAudioManager *am = [CDAudioManager sharedManager];
	if (am!=nil) {
		[am setMode:kAMM_FxOnly];
	}
	
	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	[sprite visit];
	
		
	[window addSubview:glView];																
	[window makeKeyAndVisible];		
	
	[LevelData loadState];
	
	[Appirater appLaunched:YES]; 
	
	if ([[LevelData sharedLevelData] useGameCenter]){
		if ([GameCenterManager isGameCenterAvailable]) {
			[self authenticateLocalPlayer];
		}
	}
	

	[[CCDirector sharedDirector] runWithScene: [Splash scene]];		
}

- (void) authenticateLocalPlayer
{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil)
		{
			// Insert code here to handle a successful authentication.
			NSLog(@"Game Center: Player Authenticated!");
		}
		else
		{
			// Your application can process the error parameter to report the error to the player.
			NSLog(@"Game Center: Authentication Failed!");
		}
	}];
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
