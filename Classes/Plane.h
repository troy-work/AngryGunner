//
//  Plane.h
//  AngryGunner
//
//  Created by Troy Cox on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNodeExtensions.h"
@interface Plane : CCSprite {

}

@property (assign,nonatomic) int zIndex;
@property (assign,nonatomic) int hitCount;
@property (assign,nonatomic) BOOL isDying;
@property (assign,nonatomic) int points;

-(void)die;
-(void)kill;
+(id)brownSprite;
-(void)start;


@end
