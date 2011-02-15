//
//  Game.m
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Waves.h"

@implementation Game

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Game *layer = [Game node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
		
		CCSprite *bg1 = [CCSprite spriteWithFile:@"backgroundleft.png"];
		[bg1 setAnchorPoint:ccp(1,0)];
		
	    bg1.position = ccp(241,0);

		CCSprite *bg2 = [CCSprite spriteWithFile:@"backgroundright.png"];
		[bg2 setAnchorPoint:ccp(0,0)];
		
	    bg2.position = ccp(240,0);
		
		[self addChild:bg1];
		[self addChild:bg2];
		
		Waves *waves = [Waves node];
		[self addChild:waves];
		
	}
	
	return self;	
}

-(void)startScene:(id)sender
{		
	//[[CCDirector sharedDirector] replaceScene:[StartScene node]];	
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
