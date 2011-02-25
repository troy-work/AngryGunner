//
//  Plane.m
//  AngryGunner
//
//  Created by Troy Cox on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Plane.h"


@implementation Plane

float indexZ;
CGPoint fPos;
CCAction *move;
CCTexture2D *bottomSprite;
CCTexture2D *frontSprite;
CCTexture2D *turnSprite;

@synthesize zIndex;
@synthesize hitCount;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 200;
		indexZ = 200;
		bottomSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanebottom.png"];
		frontSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanefront.png"];
		turnSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplaneturn.png"];
	}
	return self;
}

+(id)brownSprite
{
	return [self spriteWithFile:@"brownplanefront.png"];
}

-(void)start
{
	[self setPosition:ccp(840,1000)];
//	fPos = finishPos;
//	CGPoint fall = ccpAdd(fPos, ccp(0,-15));
	[self setTexture:turnSprite];
	[self setScaleX:.01];
	[self setScaleY:.015];
	[self runAction:[CCScaleBy actionWithDuration:8 scale:30]];
	move = [CCSequence actions:
			[CCMoveTo	actionWithDuration:8 position:ccp(240,300)],
			[CCCallFunc actionWithTarget:self selector:@selector(front)],			
			[CCScaleTo actionWithDuration:5 scale:1],
			[CCCallFunc actionWithTarget:self selector:@selector(turnLeft)],
			[CCScaleTo actionWithDuration:1 scale:1.5],
			[CCCallFunc actionWithTarget:self selector:@selector(turnRight)],
			[CCScaleTo actionWithDuration:.75 scale:2.5],
			[CCCallFunc actionWithTarget:self selector:@selector(spriteBottom)],
			[CCScaleTo actionWithDuration:.3 scale:4],
			[CCCallFunc actionWithTarget:self selector:@selector(kill)]
			,nil];
	[self runAction:move];
	[self schedule:@selector(step:)];

}

-(void)front
{
	[self setScaleX:[self scaleY]];
	[self setTexture:frontSprite];
	[self setRotation:45];
	[self runAction:[CCRotateTo actionWithDuration:.6 angle:0]];
}

-(void)turnLeft
{
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:-40]];
	[self runAction:[CCMoveBy actionWithDuration:.3 position:ccp(-50,-10)]];
}

-(void)turnRight
{
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:40]];
	[self runAction:[CCMoveBy actionWithDuration:2 position:ccp(800,-10)]];
}

-(void)spriteBottom
{
	[self setTexture:bottomSprite];
	[self runAction:[CCMoveBy actionWithDuration:.4 position:ccp(0,1500)]];
}

-(void)kill
{
	[[self parent] removeChild:self cleanup:TRUE];
}

-(void)step:(ccTime) dt
{
//	CCLOG(@"%d",zIndex);
	[self setZIndex:200-(50*[self scaleY])];
//	if (zIndex<=1) {
//		[[self parent] removeChild:self cleanup:TRUE];
//	}
}


@end
