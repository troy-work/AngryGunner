//
//  Splash.m
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Splash.h"
#import "SimpleAudioEngine.h"
#import "Game.h"

@implementation Splash

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Splash *layer = [Splash node];
		
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
		
		SimpleAudioEngine *se = [SimpleAudioEngine sharedEngine];
		[se preloadEffect:@"load.mp3"];
		[se setEffectsVolume:2];
		[se playEffect:@"load.mp3"];
		
		CCSprite *bg = [CCSprite spriteWithFile:@"loadscreen.png"];
		[bg setAnchorPoint:ccp(.5,.5)];
		
	    bg.position = ccp(240,160);
		[bg setScale:.05];	
		[bg runAction:[CCSequence actions:[CCScaleTo actionWithDuration:2.0 scale:1],
					   [CCCallFunc actionWithTarget:self selector:@selector(countToScene:)],nil]];
		[self addChild:bg];
		
	}
	
	return self;
	
}

-(void)countToScene:(id)sender
{
	[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0],
					 [CCCallFunc actionWithTarget:self selector:@selector(startScene:)],nil]];
}

-(void)startScene:(id)sender
{		
	[[CCDirector sharedDirector] replaceScene:[Game node]];	
}


- (void)release {
	//	NSLog(@"StartLayer retain count = %d", [self retainCount]);
	[super release];
}


-(void)dealloc
{
	//	CCLOG(@"dealloc: %@", self);
	[super dealloc];	
}


@end
