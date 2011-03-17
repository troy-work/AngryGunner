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
        case 2:
            return @"ACHIEVEMENT 2 | LEVEL 1 = 3X"; 
            break;            
        case 3:
            return @"ACHIEVEMENT 3 | LEVEL 1 = 4X"; 
            break;            
        case 4:
            return @"ACHIEVEMENT 4 = 5X"; 
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
        case 2:
            return @"FOR 3X NO TORPEDOES CAN HIT YOU BEFORE YOU KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 3:
            return @"FOR 4X YOU NEED TO SCORE OVER 14000 ALL IN LEVEL 1"; 
            break;            
        case 4:
            return @"FOR 5X YOU NEED TO STAY ALIVE UNTIL LEVEL 3"; 
            break;            
        default:
            return @"";
            break;
    }    
}

+(int)getCountByMultiplier:(int) multiplier
{
    switch (multiplier) {
        case 1:
            return 3; 
            break;            
        case 2:
            return 3; 
            break;            
        case 3:
            return 1; 
            break;            
        case 4:
            return 1; 
            break;            
        default:
            return 0;
            break;
    }        
}

@end
