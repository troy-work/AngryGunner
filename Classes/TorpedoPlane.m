//
//  TorpedoPlane.m
//  AngryGunner
//
//  Created by Troy Cox on 3/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TorpedoPlane.h"
#import "Torpedo.h"
#import "Game.h"

@implementation TorpedoPlane

float indexZ;
CGPoint fPos;
CCAction *move;
CCTexture2D *tbottomSprite;
CCTexture2D *tfrontSprite;
CCTexture2D *tfrontSpriteWithout;
CCTexture2D *tturnSprite;
CCTexture2D *tsideSprite;
float randomX;
CCTexture2D *smoke;
CCTexture2D *enemyBullet;
float lastRotate;

@synthesize zIndex;
@synthesize hitCount;
@synthesize isDying;
@synthesize points;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 200;
		indexZ = 200;
		randomX = CCRANDOM_0_1()*860;
		randomX = randomX + 480;
		isDying=FALSE;
		points = 200;
		lastRotate = (CCRANDOM_0_1()*-120)-40;
		tbottomSprite = [[CCTextureCache sharedTextureCache] addImage:@"redplanebottom.png"];
		tfrontSprite = [[CCTextureCache sharedTextureCache] addImage:@"redplanefrontwith.png"];
		tfrontSpriteWithout = [[CCTextureCache sharedTextureCache] addImage:@"redplanefront.png"];
		tsideSprite = [[CCTextureCache sharedTextureCache] addImage:@"redplaneside.png"];
		tturnSprite = [[CCTextureCache sharedTextureCache] addImage:@"redplaneturn.png"];
		smoke = [[CCTextureCache sharedTextureCache] addImage:@"dpadburst.png"];
		
	}
	return self;
}

+(id)redSprite
{
	return [self spriteWithFile:@"redplanefrontwith.png"];
}

-(void)start
{
	[self setPosition:ccp(randomX,350)];
	[self setAnchorPoint:ccp(.5,.5)];
	[self setTexture:tsideSprite];
	[self setScaleX:.01];
	[self setScaleY:.015];
	
	
	[self runAction:[CCSequence actions:[CCScaleTo actionWithDuration:6 scale:.15],
					 [CCCallFunc actionWithTarget:self selector:@selector(dive)],
					 [CCScaleTo actionWithDuration:2 scale:.2],nil]];
	
	move = [CCSequence actions:
			[CCMoveTo	actionWithDuration:6 position:ccp(-540+randomX,350)],
			[CCMoveTo	actionWithDuration:2 position:ccp(-640+randomX,300)],
			[CCCallFunc actionWithTarget:self selector:@selector(front)],			
			[CCScaleTo actionWithDuration:2 scale:.45],
			[CCCallFunc actionWithTarget:self selector:@selector(turnRight)],
			[CCScaleTo actionWithDuration:.4 scale:.6],
			[CCCallFunc actionWithTarget:self selector:@selector(spriteBottom)],
			[CCScaleTo actionWithDuration:2 scale:1.5],
			[CCCallFunc actionWithTarget:self selector:@selector(kill)]
			,nil];
	[self runAction:move];
	[self schedule:@selector(step:)];
	
}

-(void)dive
{
	self.points = 300;
	[self setTexture:tturnSprite];
}


-(void)front
{
	self.points = 50;
	[self setScaleX:[self scaleY]];
	[self setTexture:tfrontSprite];
	[self runAction:[CCRotateTo actionWithDuration:.6 angle:0]];
	[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5],
					 [CCCallFunc actionWithTarget:self selector:@selector(shoot)],
					 nil]];
}

-(void)turnLeft
{
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:-40]];
	[self runAction:[CCMoveBy actionWithDuration:.3 position:ccp(-50,-10)]];
}

-(void)turnRight
{
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:40]];
	[self runAction:[CCMoveBy actionWithDuration:2 position:ccp(100,-10)]];
}

-(void)spriteBottom
{
	[self setTexture:tbottomSprite];
	[self setPoints:1000];
	[self runAction:[CCMoveBy actionWithDuration:3 position:ccp(randomX,1500)]];
}

-(void)die
{
	isDying=TRUE;
	[self unschedule:@selector(step:)];
	
	ccColor4F startColor;
	startColor.r = 0.1f;
	startColor.g = 0.1f;
	startColor.b = 0.1f;
	startColor.a = 1.0f;
	
	ccColor4F endColor;
	endColor.r = 0.1f;
	endColor.g = 0.1f;
	endColor.b = 0.1f;
	endColor.a = 0.2f;
	
	CCParticleSun *s = [CCParticleSun node];
	[s setTexture:smoke];
	[s setScale:[self scaleY]];
	[s setPosition:[self position]];
	[s setLife:2];
	[s setDuration:2];
	[s setStartColor:startColor];
	[s setEndColor:endColor];
	[s setPositionType:kCCPositionTypeGrouped];
	[[[[self parent]parent]friendsLayer] addChild:s];
	
	CCParticleExplosion *e = [CCParticleExplosion node];
	[e setScale:[self scaleY]];
	[e setPosition:[self position]];
	[e setLife:.05];
	[e setDuration:.05];
	float scl = [self scaleY]*60;
	if (scl>64) {
		scl=60;
	}
	[e setStartSize:scl];
	[e setEndSize:[self scaleY]];
	[e setEmissionRate:1000];
	[e setPositionType:kCCPositionTypeGrouped];
	[e setEndColor:endColor];
	[[[[self parent]parent]friendsLayer] addChild:e];
	
	[self kill];
}

-(void)kill
{
	
	[[self parent] removeChild:self cleanup:FALSE];
}

-(CGPoint)getRotatedPoints:(int)radius startPoint:(CGPoint)start Angle:(float)angle {
	float x = start.x+radius*sin(angle*3.14159265/180);
	float y = start.y+radius*cos(angle*3.14159265/180);
	CGPoint newPoint = ccp(x,y);
	return newPoint;
}

-(void)shoot
{
	if (!isDying){
		[self setTexture:tfrontSpriteWithout];
		
        Torpedo *torpedo = [Torpedo torpedoSprite];
        [torpedo startAt:ccpAdd([self position], ccp(0,-10)) scale:self.scaleY*.8];
        [[(Game *)[[self parent]parent]planes] addChild:torpedo];
        
	}
}

-(void)step:(ccTime) dt
{
	[self setZIndex:200-(50*[self scaleY])];
	
	if (zIndex<100) {
		self.points = 100;
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
	}
	
}


@end
