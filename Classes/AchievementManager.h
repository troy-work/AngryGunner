//
//  AchievementManager.h
//  AngryGunner
//
//  Created by Troy Cox on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AchievementManager : NSObject {
    
}

+(NSString *)getTitleByMultiplier:(int) multiplier;
+(NSString *)getCurrentTitleByMultiplier:(int) multiplier;
+(NSString *)getInstructionByMultiplier:(int) multiplier;
+(int)getCountByMultiplier:(int) multiplier;

@end
