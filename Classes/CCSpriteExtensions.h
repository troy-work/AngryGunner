//
//  CCSpriteExtensions.h
//  AngryGunner
//
//  Created by Troy Cox on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCSprite (Utility)

int zIndex;

-(bool)isCollidingWith:(CCSprite *)sprite atZIndex: (int) z;

@end
