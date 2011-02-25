//
//  Bullet.m
//  AngryGunner
//
//  Created by Troy Cox on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"
#import "Plane.h"

@implementation Bullet

float indexZ;
CGPoint fPos;
CCAction *move;

-(id)init 
{
	if ((self = [super init])) {
		zIndex = 0;
		indexZ = 0;
	}
	return self;
}
-(void)startAtPosition: (CGPoint) startPos finishAtPosition: (CGPoint) finishPos
{
	[self setPosition:startPos];
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
	indexZ += 100*dt;
	zIndex = (int)indexZ;
	[self setRotation:[self rotation]+120];
	[self setScale:(2-(zIndex*.01)*1)];
	if (zIndex>=199) {
		[[self parent] removeChild:self cleanup:TRUE];
	}
	
	for (Plane *p in [[[[self parent]parent]planes]children]){
		if (p.zIndex<zIndex+5&&p.zIndex>zIndex-5) {
			float lx = p.position.x - p.contentSize.width/3;
			float rx = p.position.y + p.contentSize.width/3;
			if (self.position.x>lx&&self.position.x<rx) {
				float ty = p.position.y + p.contentSize.height/3;
				float by = p.position.y - p.contentSize.height/3;
				if (self.position.y>by&&self.position.y<ty) {
					p.hitCount += 1;
					if (p.hitCount>4) {
						[p kill];
					}
					[[self parent] removeChild:self cleanup:TRUE];
				}
			}
		}
	}
}


@end
