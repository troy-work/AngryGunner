//
//  Help.m
//  AngryGunner
//
//  Created by Troy Cox on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Help.h"
#import "Start.h"

@implementation Help

+(id)scene{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Help *layer = [Help node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init
{
	if( (self=[super init])) 
	{
				
		CCSprite *bg = [CCSprite spriteWithFile:@"helpscreen.jpg"];
		[bg setAnchorPoint:ccp(0,0)];		
		
	    bg.position = ccp(0,0);
		[self addChild:bg];
		
		
		CCMenuItem *home = [CCMenuItemFont itemFromString:@"HOME" target:self selector:@selector(startHome:)];
		
		home.position = ccp(10,295);
		
		CCMenu *menu = [CCMenu menuWithItems: home,nil];
		menu.position = ccp(0,0);
		[menu setOpacity:0];
		[self addChild:menu];
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

-(void)release
{
    [[CCTextureCache sharedTextureCache] removeTextureForKey:@"helpscreen.jpg"];

	[super release];
}


@end
