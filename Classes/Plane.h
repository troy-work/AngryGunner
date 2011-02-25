//
//  Plane.h
//  AngryGunner
//
//  Created by Troy Cox on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface Plane : CCSprite {

}

@property (assign,nonatomic) int zIndex;
@property (assign,nonatomic) int hitCount;

-(void)die;
-(void)kill;
+(id)brownSprite;
-(void)start;

@end
