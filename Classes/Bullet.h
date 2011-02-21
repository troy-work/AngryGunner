//
//  Bullet.h
//  AngryGunner
//
//  Created by Troy Cox on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSpriteExtensions.h"
@interface Bullet : CCSprite {
}

-(void)startAtPosition: (CGPoint) startPos finishAtPosition: (CGPoint) finishPos;

@end
