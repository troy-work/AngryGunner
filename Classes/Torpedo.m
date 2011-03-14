//
//  Torpedo.m
//  AngryGunner
//
//  Created by Troy Cox on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Torpedo.h"
#import "Game.h"

@implementation Torpedo

float indexZ;
CGPoint fPos;
CCAction *move;
CCTexture2D *smoke;
int countTail;

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
		isDying=FALSE;
		points = 100;
        countTail = 260;
		smoke = [[CCTextureCache sharedTextureCache] addImage:@"dpadburst.png"];
        
	}
	return self;
}

-(void)hitBoat
{
    [self setState:@"tHitBoat"];
    [(Game *)[[self parent]parent] setHealth:[(Game *)[[self parent]parent]health]-10];

}

- (void) explode {
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
	
    if (smoke!=nil) {
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
    }
	
	CCParticleExplosion *e = [CCParticleExplosion node];
	[e setScale:[self scaleY]];
	[e setPosition:[self position]];
	[e setLife:.1];
	[e setDuration:.1];
	float scl = [self scaleY]*100;
	if (scl>64) {
		scl=60;
	}
	[e setStartSize:scl];
	[e setEndSize:[self scaleY]];
	[e setEmissionRate:1000];
	[e setPositionType:kCCPositionTypeGrouped];
	[e setEndColor:endColor];
	[[[[self parent]parent]friendsLayer] addChild:e];
}
-(void)die
{
	isDying=TRUE;
	[self unschedule:@selector(step:)];

	[self explode];        
   	[self kill]; 
}
-(void)kill
{
	[(Game *)[[self parent]parent]checkAchievement:[self state]];    
	[[self parent] removeChild:self cleanup:FALSE];    
}
+(id)torpedoSprite
{
    return [self spriteWithFile:@"torpedo.png"];
}
-(void)startAt:(CGPoint)pos scale:(float)scale
{
    [self setState:@"tFalling"];
	[self setPosition:pos];
	[self setAnchorPoint:ccp(.5,.5)];
	[self setScale:scale];
		
	[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1],
                     [CCCallFunc actionWithTarget:self selector:@selector(startTail)],
					 [CCScaleTo actionWithDuration:20 scale:1.5],nil]];
	
	move = [CCSequence actions:
			[CCMoveBy actionWithDuration:1 position:ccp(0,-25)],            
			[CCMoveBy actionWithDuration:20 position:ccp(0,-220)],
			[CCCallFunc actionWithTarget:self selector:@selector(hitBoat)],
			[CCCallFunc actionWithTarget:self selector:@selector(kill)]
			,nil];
	[self runAction:move];
    
}

-(void)startTail
{
    [self setState:@"tTail"];
    [self setPoints:50];
	[self schedule:@selector(step:)];
    [self setOpacity:90];
}

-(void)step:(ccTime) dt
{
	[self setZIndex:200-(150*[self scale])];
    countTail -=50*dt;
    if (countTail<=0) {
        countTail=20;
        CCSprite *tail = [CCSprite spriteWithFile:@"bulletSplash.png"];
        [tail setOpacity:50];
        [tail setAnchorPoint:ccp(.5,0)];
        [tail setPosition:ccpAdd([self position], ccp(0,5))];
        [tail runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5],
                         [CCCallFuncN actionWithTarget:[(Game *)[self parent]parent] 
                                                                 selector:@selector(killEnemySplash:)],nil]];
        [tail setScaleX:self.scaleX*2];
        [tail setScaleY:self.scaleX*2];
        [[[[self parent]parent]friendsLayer] addChild:tail];        
    }
}

@end
