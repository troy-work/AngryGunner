//
//  LevelData.h
//  The Drop
//
//  Created by Troy Cox on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynthesizeSingleton.h"
#import "CCScene.h"

@interface LevelData : NSObject
{

}

@property (assign,nonatomic) int score;
@property (assign,nonatomic) int highScore;
@property (assign,nonatomic) bool useGameCenter;
@property (assign,nonatomic) bool difficultOn;
@property (assign,nonatomic) bool torpedoesOn;
@property (assign,nonatomic) bool shouldPlaySfx;
@property (assign,nonatomic) int currentMultiplier;

+ (LevelData *)sharedLevelData;
+(void)loadState;
+(void)saveState;
+(void)loadMultiplier;
+(void)saveMultiplier;


@end
