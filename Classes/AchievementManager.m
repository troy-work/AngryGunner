//
//  AchievementManager.m
//  AngryGunner
//
//  Created by Troy Cox on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AchievementManager.h"


@implementation AchievementManager

+(NSString *)getTitleByMultiplier:(int) multiplier
{
    switch (multiplier) {
        case 1:
            return @"ACHIEVEMENT 1 | LEVEL 1 = 2X"; 
            break;            
        default:
            return @"";
            break;
    }
}

+(NSString *)getInstructionByMultiplier:(int) multiplier
{
    switch (multiplier) {
        case 1:
            return @"FOR 2X YOU NEED TO KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        default:
            return @"";
            break;
    }
    
}

@end
