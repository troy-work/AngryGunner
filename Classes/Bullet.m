//
//  Bullet.m
//  AngryGunner
//
//  Created by Troy Cox on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"
#import "Plane.h"
#import "Game.h"

@implementation Bullet

float indexZ;
CGPoint fPos;
CCAction *move;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 1;
		indexZ = 1;
	}
	return self;
}
-(void)startAtPosition: (CGPoint) startPos finishAtPosition: (CGPoint) finishPos
{
	[self setPosition:startPos];
	[self setScale:2];
	fPos = finishPos;
	CGPoint fall = ccpAdd(fPos, ccp(0,-15));
	move = [CCSequence actions:[CCMoveTo actionWithDuration:.05 position:fPos],
			[CCFlipY actionWithFlipY:TRUE],
			[CCMoveTo actionWithDuration:1 position:fall],nil];
	[self runAction:move];
	[self schedule:@selector(step:)];
}

-(void)step:(ccTime) dt
{
	indexZ += 200*dt;
	zIndex = (int)indexZ;
	[self setScale:(2-(zIndex*.01)*1)];
	if (zIndex>=199) {
		[[self parent] removeChild:self cleanup:TRUE];
	}
	
	for (Plane *p in [[[[self parent]parent]planes]children]){
		if (p.zIndex<zIndex+8&&p.zIndex>zIndex-8) 
		{
			float lx = p.position.x - p.scaledSize.width*.4;
			float ty = p.position.y + p.scaledSize.height*.4;
			float by = p.position.y - p.scaledSize.height*.4;
			if ((self.position.x>lx&&self.position.x<lx+p.scaledSize.width*8)
				&&(self.position.y>by&&self.position.y<ty)) 
			{
				int score = p.points;
				
				if (score==100) {
					score = 500;
				}

				CCLabelBMFont *bonus = [CCLabelBMFont labelWithString:
						[NSString stringWithFormat:@"%i",score]									   
								fntFile:@"321impact.fnt"];
				
				// testing anchors
				float xx = [(Game *)[[self parent]parent] x];
				float yy = [(Game *)[[self parent]parent] y];
				
				CGPoint bp = ccpAdd(p.position, ccp(xx,yy));
				
				bonus.anchorPoint = ccp(.5,0);
				[bonus setPosition:bp];
				[bonus setScale:.5];
				[bonus runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.5],
								  [CCCallFuncN actionWithTarget:[[self parent] parent] 
													   selector:@selector(killSprite:)],nil]];
				[[[self parent] parent] addChild:bonus z:0];
				
				[[[self parent]parent] setScore:[[[self parent]parent] score] + score];
				
				p.hitCount += 1;
				if (p.hitCount>2) {
					[p die];
				[[self parent] removeChild:self cleanup:TRUE];
				}
			}
		}
				
	}
	
	if (indexZ>83) {
		
		float collisionZ = indexZ-83 + self.position.y;
		if (self.position.y<270) {
			if (self.position.y<(147+collisionZ+4)||self.position.y>(147+collisionZ-4)) {
				[self unschedule:@selector(step:)];
				CCSprite *splash = [CCSprite spriteWithFile:@"bulletSplash.png"];
				float sScale = CCRANDOM_0_1()*(.4*270/self.position.y);
				float sScaleY = CCRANDOM_0_1()*(.1*270/self.position.y);
				[splash setOpacity:200];
				[splash setAnchorPoint:ccp(.5,0)];
				[splash setScale:sScale];
				[splash setScaleY:(sScaleY)*4];
				[splash setPosition:self.position];
				[splash runAction:[CCSequence actions:[CCScaleBy actionWithDuration:.1 scale:2],
								   [CCScaleBy actionWithDuration:.1 scale:.1],
								   [CCCallFuncN actionWithTarget:[(Game *)[self parent]parent] 
													   selector:@selector(killEnemySplash:)],nil]];
				
				[[[(Game *)[self parent]parent] friendsLayer]addChild:splash];
				[[self parent] removeChild:self cleanup:TRUE];
			}
		}
	}	
}


@end
