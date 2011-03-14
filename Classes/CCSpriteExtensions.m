//
//  CCSpriteExtensions.m
//  AngryGunner
//
//  Created by Troy Cox on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSpriteExtensions.h"

@implementation CCSprite (Utility)

-(int)zIndex
{
	return zIndex;
}

-(void)setZIndex:(int) z
{
	zIndex = z;
}
-(bool)isCollidingWith:(CCSprite *)sprite atZIndex: (int) z
{
	if ([sprite zIndex]==zIndex) {
		return TRUE;
	}
	return FALSE;
}

@end
