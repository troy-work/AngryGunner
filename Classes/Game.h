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
-(void)killSprite:(CCSprite *)sender;
-(void)fireBullets;
-(void)killEnemySplash:(CCSprite *)sender;
-(CGPoint)getRotatedPoints:(int)radius startPoint:(CGPoint)start Angle:(float)angle;
- (void)saveGLScreenshotToPhotosAlbum;
-(void)getPic;
-(void)checkAchievement:(NSString *)s;

@property (assign,nonatomic) CCLayer *planes;
@property (assign,nonatomic) CCLayer *bullets;
@property (assign,nonatomic) CCLayer *friendsLayer;
@property (assign,nonatomic) CCLayer *gunner;
@property (assign,nonatomic) float health;
@property (assign,nonatomic) float x;
@property (assign,nonatomic) float y;
@property (assign,nonatomic) CCSprite *radar;
@property (assign,nonatomic) int score;
@property (assign,nonatomic) int countDownAchievement;
@property (assign,nonatomic) bool didAchievement;


@end
