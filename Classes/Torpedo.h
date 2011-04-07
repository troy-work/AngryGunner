//
//  Torpedo.h
//  AngryGunner
//
//  Created by Troy Cox on 3/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Torpedo : CCSprite {
    
}

@property (assign,nonatomic) int zIndex;
@property (assign,nonatomic) int hitCount;
@property (assign,nonatomic) BOOL isDying;
@property (assign,nonatomic) int points;
@property (assign,nonatomic) NSString *state;

-(void)die;
-(void)kill;
+(id)torpedoSprite;
-(void)startAt:(CGPoint)pos scale:(float)scale;
-(void)hit;

@end
