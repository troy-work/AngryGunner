//
//  Game.h
//  AngryGunner
//
//  Created by Troy Cox on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Game : CCLayer {

}

+(id)scene;
-(void)fireBullets;
@property (assign,nonatomic) CCLayer *planes;
@property (assign,nonatomic) CCLayer *bullets;
@property (assign,nonatomic) CCLayer *friendsLayer;
@property (assign,nonatomic) CCLayer *gunner;
@property (assign,nonatomic) float health;

@end
