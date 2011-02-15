//
//  GameScene.h
//  Cocos2dManager
//
//  Created by Troy Cox on 1/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpaceManagerCocos2d.h"

@interface GameScene : CCLayer
{
	SpaceManagerCocos2d *smgr;
	CGPoint _lastPt;
}

-(void) step: (ccTime) dt;
-(BOOL) drawTerrainAt:(CGPoint)pt;

@end
