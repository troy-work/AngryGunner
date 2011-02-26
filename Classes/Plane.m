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
CCTexture2D *frontSpriteShoot;
CCTexture2D *turnSprite;
float randomX;
CCTexture2D *smoke;
float shootTime;
BOOL isDying;

@synthesize zIndex;
@synthesize hitCount;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 200;
		indexZ = 200;
		randomX = CCRANDOM_0_1()*300;
		randomX += 660;
		shootTime = 100;
		isDying=FALSE;
		bottomSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanebottom.png"];
		frontSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanefront.png"];
		frontSpriteShoot = [[CCTextureCache sharedTextureCache] addImage:@"brownplanefrontshoot.png"];
		turnSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplaneturn.png"];
		smoke = [[CCTextureCache sharedTextureCache] addImage:@"dpadburst.png"];

	}
	return self;
}

+(id)brownSprite
{
	return [self spriteWithFile:@"brownplanefront.png"];
}

-(void)start
{
	[self setPosition:ccp(randomX,1000)];
	[self setAnchorPoint:ccp(.5,.5)];
	isDying=FALSE;
//	fPos = finishPos;
//	CGPoint fall = ccpAdd(fPos, ccp(0,-15));

	[self setTexture:turnSprite];
	[self setScaleX:.01];
	[self setScaleY:.015];
	[self runAction:[CCScaleBy actionWithDuration:8 scale:30]];
	move = [CCSequence actions:
			[CCMoveTo	actionWithDuration:8 position:ccp(-640+randomX,300)],
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
	if (!isDying){
	[self setScaleX:[self scaleY]];
	[self setTexture:frontSprite];
	[self setRotation:45];
	[self runAction:[CCRotateTo actionWithDuration:.6 angle:0]];
	}
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

-(void)die
{
	isDying=TRUE;
	CCParticleSun *s = [CCParticleSun node];
	[s setTexture:smoke];
	[s setScale:[self scaleY]];
	[s setPosition:[self position]];
	[s setLife:2];
	[s setDuration:2];
	ccColor4F startColor;
	startColor.r = 0.1f;
	startColor.g = 0.1f;
	startColor.b = 0.1f;
	startColor.a = 1.0f;
	[s setStartColor:startColor];
	ccColor4F endColor;
	endColor.r = 0.8f;
	endColor.g = 0.8f;
	endColor.b = 0.8f;
	endColor.a = 0.8f;
	[s setEndColor:endColor];
	[s setPositionType:kCCPositionTypeGrouped];
	[[[[self parent]parent]friendsLayer] addChild:s];
	[s release];
	
	[self kill];
}

-(void)kill
{
	isDying=TRUE;
	
	[[self parent] removeChild:self cleanup:TRUE];
}

-(void)shoot
{
	if (!isDying){
	[self setTexture:frontSpriteShoot];
	[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.1],
	 [CCCallFunc actionWithTarget:self selector:@selector(stopShooting)],nil]];
	}
}

-(void)stopShooting
{
	if(!isDying){
	[self setTexture:frontSprite];
	}
}

-(void)step:(ccTime) dt
{
	[self setZIndex:200-(50*[self scaleY])];
	
	
	shootTime -= dt*CCRANDOM_0_1()*300;
	if (shootTime<=0) {
		shootTime = 100;
		if(self.texture == frontSprite)
		[self shoot];
	}
	
	if (hitCount>0) {
		CCParticleSmoke *s = [CCParticleSmoke node];
		[s setTexture:smoke];
		[s setScale:[self scaleY]*2];
		[s setPosition:[self position]];
		[s setLife:1];
		[s setDuration:.1];
		ccColor4F startColor;
		startColor.r = 1.0f;
		startColor.g = 0.4f;
		startColor.b = 0.1f;
		startColor.a = .8f;
		[s setStartColor:startColor];
		ccColor4F endColor;
		endColor.r = 0.8f;
		endColor.g = 0.8f;
		endColor.b = 0.8f;
		endColor.a = 0.8f;
		[s setEndColor:endColor];
		[s setPositionType:kCCPositionTypeGrouped];
		[[[[self parent]parent]friendsLayer] addChild:s];
		[s release];
		
	}
	
}


@end
