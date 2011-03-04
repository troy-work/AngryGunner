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
	indexZ += 200*dt;
	zIndex = (int)indexZ;
//	[self setRotation:[self rotation]+120];
	[self setScale:(2-(zIndex*.01)*1)];
	if (zIndex>=199) {
		[[self parent] removeChild:self cleanup:TRUE];
	}
	
	for (Plane *p in [[[[self parent]parent]planes]children]){
		if (p.zIndex<zIndex+8&&p.zIndex>zIndex-8) 
		{
			float lx = p.position.x - p.scaledSize.width/3;
			float ty = p.position.y + p.scaledSize.height/3;
			float by = p.position.y - p.scaledSize.height/3;
			if ((self.position.x>lx&&self.position.x<lx+p.scaledSize.width*.6)
				&&(self.position.y>by&&self.position.y<ty)) 
			{
//					CCLOG(@"Self x: %d",self.position.x);
//					CCLOG(@"lx: %d",lx);
//					CCLOG(@"rx: %d",rx);
//					CCLOG(@"Self y: %d",self.position.y);
//					CCLOG(@"ty: %d",ty);
//					CCLOG(@"by: %d",by);
				
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
}


@end
