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
            return @"\nACHIEVEMENT 2X"; 
            break;            
        case 2:
            return @"\nACHIEVEMENT 3X"; 
            break;            
        case 3:
            return @"\nACHIEVEMENT 4X"; 
            break;            
        case 4:
            return @"\nACHIEVEMENT 5X"; 
            break;            
        case 5:
            return @"\nACHIEVEMENT 6X"; 
            break;            
        case 6:
            return @"\nACHIEVEMENT 7X"; 
            break;            
        case 7:
            return @"\nACHIEVEMENT 8X"; 
            break;            
        case 8:
            return @"\nACHIEVEMENT 9X"; 
            break;            
        case 9:
            return @"\nACHIEVEMENT 10X"; 
            break;            
        case 10:
            return @"\nACHIEVEMENT 11X"; 
            break;            
        case 11:
            return @"\nACHIEVEMENT 12X"; 
            break;            
        case 12:
            return @"\nACHIEVEMENT 13X"; 
            break;            
        case 13:
            return @"\nACHIEVEMENT 14X"; 
            break;            
        case 14:
            return @"\nACHIEVEMENT 15X"; 
            break;            
        case 15:
            return @"\nACHIEVEMENT 16X"; 
            break;            
        case 16:
            return @"\nACHIEVEMENT 17X"; 
            break;            
        case 17:
            return @"\nACHIEVEMENT 18X"; 
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
        case 10:
            return @"\nPROVE YOUR SKILL. FOR 11X, YOU MUST SCORE MORE THAN 50000 IN LEVEL 1."; 
            break;            
        case 11:
            return @"\nTIME FOR BIG SCORE AND SHARP SHOOTING. FOR 12X KILL A TORPEDO PLANE AFTER IT DROPS THE TORPEDO AND IS CLIMBING AWAY."; 
            break;            
        case 12:
            return @"\nEASY MONEY. FOR 13X, KILL EVERY PLANE AND NEVER GET HIT WITH A TORPEDO FOR ALL OF LEVEL 1."; 
            break;            
        case 13:
            return @"\nFOR 14X, KILL A FIGHTER DODGING TO YOUR LEFT."; 
            break;            
        case 14:
            return @"\nFOR 15X, KILL EVERY FIGHTER DODGING TO YOUR LEFT FOR ALL OF LEVEL 1."; 
            break;            
        case 15:
            return @"\nFOR 16X, YOU HAVE TO MAKE IT ALL THE WAY TO LEVEL 4 WITHOUT A CRACKED GLASS!!."; 
            break;            
        case 16:
            return @"\nFOR 17X, YOU HAVE TO GET YOUR GLASS CRACKED IN LEVEL 1. IT'S HARDER THAN IT SOUNDS."; 
            break;            
        case 17:
            return @"\nFOR 18X, YOU HAVE TO FINISH LEVEL 1 WITH EXACTLY 27200 POINTS."; 
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
        case 10:
            return 1; 
            break;            
        case 11:
            return 1; 
            break;            
        case 12:
            return 1; 
            break;            
        case 13:
            return 1; 
            break;            
        case 14:
            return 10; 
            break;            
        case 15:
            return 1; 
            break;            
        case 16:
            return 1; 
            break;            
        case 17:
            return 1; 
            break;            
        default:
            return 0;
            break;
    }        
}

@end
