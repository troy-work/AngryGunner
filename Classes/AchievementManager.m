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
            return @"\nACHIEVEMENT 1 | LEVEL 1 = 2X"; 
            break;            
        case 2:
            return @"\nACHIEVEMENT 2 | LEVEL 1 = 3X"; 
            break;            
        case 3:
            return @"\nACHIEVEMENT 3 | LEVEL 1 = 4X"; 
            break;            
        case 4:
            return @"\nACHIEVEMENT 4 = 5X"; 
            break;            
        case 5:
            return @"\nACHIEVEMENT 5 = 6X"; 
            break;            
        case 6:
            return @"\nACHIEVEMENT 6 = 7X"; 
            break;            
        case 7:
            return @"\nACHIEVEMENT 7 = 8X"; 
            break;            
        case 8:
            return @"\nACHIEVEMENT 8 = 9X"; 
            break;            
        case 9:
            return @"\nACHIEVEMENT 9 = 10X"; 
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
            return @"\nFOR 2X YOU NEED TO KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 2:
            return @"\nFOR 3X NO TORPEDOES CAN HIT YOU BEFORE YOU KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 3:
            return @"\nFOR 4X YOU NEED TO SCORE OVER 14000 ALL IN LEVEL 1"; 
            break;            
        case 4:
            return @"\nFOR 5X YOU NEED TO STAY ALIVE UNTIL LEVEL 3"; 
            break;            
        case 5:
            return @"\nFOR 6X YOU NEED TO STAY ALIVE UNTIL LEVEL 3. BUT, THIS TIME WITHOUT A TORPEDO HIT!"; 
            break;            
        case 6:
            return @"\nFOR 7X YOU CAN'T ALLOW A SINGLE TORPEDO PLANE TO ESCAPE IN ALL OF LEVEL 1."; 
            break;            
        case 7:
            return @"\nFOR 8X KILL A TORPEDO PLANE WHILE IT IS CROSSING, BEFORE IT DIVES."; 
            break;            
        case 8:
            return @"\nFOR 9X KILL A FIGHTER IN IT'S LONG DIVE, BEFORE IT TURNS TOWARD YOU."; 
            break;            
        case 9:
            return @"\nFOR 10X KILL A TORPEDO PLANE IN IT'S SHORT DIVE, AFTER IT CROSSES, BUT, BEFORE IT TURNS TOWARD YOU."; 
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
        case 5:
            return 1; 
            break;            
        case 6:
            return 1; 
            break;            
        case 7:
            return 1; 
            break;            
        case 8:
            return 1; 
            break;            
        case 9:
            return 1; 
            break;            
        default:
            return 0;
            break;
    }        
}

@end
