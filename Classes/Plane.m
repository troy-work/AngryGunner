//
//  Plane.m
//  AngryGunner
//
//  Created by Troy Cox on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Plane.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

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
CCTexture2D *enemyBullet;
float lastRotate;
SimpleAudioEngine *se;
int planeSoundId;

@synthesize zIndex;
@synthesize hitCount;
@synthesize isDying;
@synthesize points;
@synthesize state;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 200;
		indexZ = 200;
		randomX = CCRANDOM_0_1()*880;
		randomX = randomX + 440;
		shootTime = 100;
		isDying=FALSE;
		points = 100;
		lastRotate = (CCRANDOM_0_1()*-120)-40;
		bottomSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanebottom.png"];
		frontSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplanefront.png"];
		frontSpriteShoot = [[CCTextureCache sharedTextureCache] addImage:@"brownplanefrontshoot.png"];
		turnSprite = [[CCTextureCache sharedTextureCache] addImage:@"brownplaneturn.png"];
		smoke = [[CCTextureCache sharedTextureCache] addImage:@"dpadburst.png"];
        se = [SimpleAudioEngine sharedEngine];
        [se preloadEffect:@"explosion.aiff"];
        [se preloadEffect:@"PlaneMachineGun.aiff"];
        [se preloadEffect:@"p51fast.aiff"];
        [self setTag:kPlane];
	}
	return self;
}

+(id)brownSprite
{
	return [self spriteWithFile:@"brownplanefront.png"];
}

-(void)hit
{
    [se playEffect:@"explosion.aiff" pitch:1 pan:0 gain:[self scaleX]];

    hitCount+=1;
}

-(void)start
{
    [self setState:@"fDiving"];
	[self setPosition:ccp(randomX,1000)];
	[self setAnchorPoint:ccp(.5,.5)];
	[self setTexture:turnSprite];
	[self setScaleX:.01];
	[self setScaleY:.015];
	[self runAction:[CCScaleTo actionWithDuration:8 scale:.20]];
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
			[CCCallFunc actionWithTarget:self selector:@selector(removeSelf)]
			,nil];
	[self runAction:move];
	[self schedule:@selector(step:)];

}

-(void)removeSelf
{
    [self setState:@"fMissed"];
	[self kill];
}


-(void)front
{
    [self setState:@"fFront"];
	self.points = 25;
	[self setScaleX:[self scaleY]];
	[self setTexture:frontSprite];
	[self setRotation:45];
	[self runAction:[CCRotateTo actionWithDuration:.6 angle:0]];
}

-(void)turnLeft
{
    [self setState:@"fLeft"];
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:-40]];
	[self runAction:[CCMoveBy actionWithDuration:.3 position:ccp(-50,-10)]];
    planeSoundId = [se playEffect:@"p51fast.aiff" pitch:1 pan:0 gain:[self scaleX]];

}

-(void)turnRight
{
    [self setState:@"fRight"];
	[self runAction:[CCRotateTo actionWithDuration:.2 angle:40]];
	[self runAction:[CCMoveBy actionWithDuration:2 position:ccp(800,-10)]];
}

-(void)spriteBottom
{
    [self setState:@"fClimb"];
    [self setPoints:500];
	[self setTexture:bottomSprite];
	[self runAction:[CCMoveBy actionWithDuration:.4 position:ccp(0,1500)]];
}

-(void)die
{
    [se stopEffect:planeSoundId];
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
	[(Game *)[[self parent]parent]checkAchievement:[self state]];
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
        
        [se playEffect:@"PlaneMachineGun.aiff" pitch:1 pan:0 gain:[self scaleX]/16 ];
        
		float lrot = (CCRANDOM_0_1()*-120)-40;
		float diff = abs((int)(lrot-lastRotate));
		if (diff>5) {
			if (lrot>lastRotate) {
				lrot+=lastRotate+5;
			} else {
				lrot-=lastRotate-5;
			}
			if (lrot<-120) {
				lrot=-120;
			}
			if (lrot>-40) {
				lrot=-40;
			}
		}		
		lastRotate = lrot;
		float rrot = -1*lrot;
		float bscale = (CCRANDOM_0_1()*2);
		if ([self rotation]<0) {
			lrot = lrot + [self rotation];
			rrot = rrot + [self rotation];
		}
		if ([self rotation]>0) {
			lrot = lrot - [self rotation];
			rrot = rrot + [self rotation];
		}
		
		[[[self parent]parent]enemyPlaneBulletWithPosition:
		 [self getRotatedPoints:32 startPoint:ccpAdd([self position],ccp(0,-6)) Angle:[self rotation]-90]
											   withBulletRotation: (int)lrot								  
												  withScale:self.scaleX
														andBulletScale:bscale];
		[[[self parent]parent]enemyPlaneBulletWithPosition:
		 [self getRotatedPoints:32 startPoint:ccpAdd([self position],ccp(0,-6)) Angle:[self rotation]-270]
										withBulletRotation: (int)rrot								  
												  withScale:self.scaleX
														andBulletScale:bscale];
		
		[self setTexture:frontSpriteShoot];
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.1],
						 [CCCallFunc actionWithTarget:self selector:@selector(stopShooting)],nil]];
		
	}
}

-(void)stopShooting
{

	if (!isDying){
	[self setTexture:frontSprite];
	}
}

-(void)step:(ccTime) dt
{
	[self setZIndex:200-(50*[self scaleY])];
	
	if (zIndex<100) {
		self.points = 50;
	}
	
	shootTime -= dt*CCRANDOM_0_1()*300;
	if (shootTime<=0) {
		shootTime = 50;
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
	}
	
}


@end
