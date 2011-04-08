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
        case 0:
            return @"SEAMAN RECRUIT"; 
            break;                        
        case 1:
            return @"SEAMAN APPRENTICE"; 
            break;            
        case 2:
            return @"SEAMAN"; 
            break;            
        case 3:
            return @"PETTY OFFICER THIRD CLASS"; 
            break;            
        case 4:
            return @"PETTY OFFICER SECOND CLASS"; 
            break;            
        case 5:
            return @"PETTY OFFICER FIRST CLASS"; 
            break;            
        case 6:
            return @"CHIEF PETTY OFFICER"; 
            break;            
        case 7:
            return @"SENIOR CHIEF PETTY OFFICER"; 
            break;            
        case 8:
            return @"MASTER CHIEF PETTY OFFICER"; 
            break;            
        case 9:
            return @"MASTER CHIEF PETTY OFFICER OF THE NAVY"; 
            break;            
        case 10:
            return @"ENSIGN"; 
            break;            
        case 11:
            return @"LIEUTENANT JUNIOR GRADE"; 
            break;            
        case 12:
            return @"LIEUTENANT"; 
            break;            
        case 13:
            return @"LIEUTENANT COMMANDER"; 
            break;            
        case 14:
            return @"COMMANDER"; 
            break;            
        case 15:
            return @"CAPTAIN"; 
            break;            
        case 16:
            return @"REAR ADMIRAL \n(LOWER HALF)"; 
            break;            
        case 17:
            return @"REAR ADMIRAL \n(UPPER HALF)"; 
            break;            
        case 18:
            return @"VICE ADMIRAL"; 
            break;            
        case 19:
            return @"ADMIRAL"; 
            break;            
        case 20:
            return @"FLEET ADMIRAL"; 
            break;            
        case 21:
            return @"CONGRADULATIONS"; 
            break;            
        default:
            return @"";
            break;
    }
}


+(NSString *)getCurrentTitleByMultiplier:(int) multiplier
{
    return [self getTitleByMultiplier:multiplier-1];
}


+(NSString *)getInstructionByMultiplier:(int) multiplier
{
    switch (multiplier) {
        case 1:
            return @"\nFOR SEAMAN APPRENTICE YOU NEED TO KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 2:
            return @"\nFOR SEAMAN NO TORPEDOES CAN HIT YOU BEFORE YOU KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 3:
            return @"\nFOR PETTY OFFICER THIRD CLASS YOU NEED TO SCORE OVER 14000 ALL IN LEVEL ONE"; 
            break;            
        case 4:
            return @"\nFOR PETTY OFFICER SECOND CLASS YOU NEED TO STAY ALIVE UNTIL LEVEL THREE"; 
            break;            
        case 5:
            return @"\nFOR PETTY OFFICER FIRST CLASS YOU NEED TO STAY ALIVE UNTIL LEVEL THREE. BUT, THIS TIME WITHOUT A TORPEDO HIT!"; 
            break;            
        case 6:
            return @"\nFOR CHIEF PETTY OFFICER YOU CAN'T ALLOW A SINGLE TORPEDO PLANE TO ESCAPE IN ALL OF LEVEL ONE."; 
            break;            
        case 7:
            return @"\nFOR SENIOR CHIEF PETTY OFFICER KILL A TORPEDO PLANE WHILE IT IS CROSSING, BEFORE IT DIVES."; 
            break;            
        case 8:
            return @"\nFOR MASTER CHIEF PETTY OFFICER KILL A FIGHTER IN IT'S LONG DIVE, BEFORE IT TURNS TOWARD YOU."; 
            break;            
        case 9:
            return @"\nFOR MASTER CHIEF PETTY OFFICER OF THE NAVY KILL A TORPEDO PLANE IN IT'S SHORT DIVE, AFTER IT CROSSES, BUT, BEFORE IT TURNS TOWARD YOU."; 
            break;            
        case 10:
            return @"\nPROVE YOUR SKILL. FOR ENSIGN, YOU MUST SCORE MORE THAN 50000 IN LEVEL ONE."; 
            break;            
        case 11:
            return @"\nTIME FOR BIG SCORE AND SHARP SHOOTING. FOR LIEUTENANT JUNIOR GRADE KILL A TORPEDO PLANE AFTER IT DROPS THE TORPEDO AND IS CLIMBING AWAY."; 
            break;            
        case 12:
            return @"\nEASY MONEY. FOR LIEUTENANT, KILL EVERY PLANE AND NEVER GET HIT WITH A TORPEDO FOR ALL OF LEVEL ONE."; 
            break;            
        case 13:
            return @"\nFOR LIEUTENANT COMMANDER, KILL A FIGHTER DODGING TO YOUR LEFT."; 
            break;            
        case 14:
            return @"\nFOR COMMANDER, KILL EVERY FIGHTER DODGING TO YOUR LEFT FOR ALL OF LEVEL ONE."; 
            break;            
        case 15:
            return @"\nFOR CAPTAIN, YOU HAVE TO MAKE IT ALL THE WAY TO LEVEL 4 WITHOUT A CRACKED GLASS!!."; 
            break;            
        case 16:
            return @"\nFOR REAR ADMIRAL (LOWER HALF), YOU HAVE TO GET YOUR GLASS CRACKED IN LEVEL 1. IT'S HARDER THAN IT SOUNDS."; 
            break;            
        case 17:
            return @"\nFOR REAR ADMIRAL (UPPER HALF), YOU HAVE TO FINISH LEVEL 1 WITH EXACTLY 27200 POINTS."; 
            break;            
        case 18:
            return @"\nFOR VICE ADMIRAL, THE CHALLENGE IS ON. YOU HAVE TO SCORE OVER 320K. YES SIR, THAT'S \n320,000."; 
            break;            
        case 19:
            return @"\nFOR ADMIRAL, KILL EVERY PLANE AND NEVER GET HIT WITH A TORPEDO FOR ALL OF LEVEL ONE AND LEVEL TWO."; 
            break;            
        case 20:
            return @"\nFINALLY, FLEET ADMIRAL, WITH ALL YOUR SKILL YOU MUST SCORE OVER 140000 ALL IN LEVEL ONE."; 
            break;            
        case 21:
            return @"\nAWESOME. NOW THAT YOU HAVE ARRIVED, YOU CAN REALLY POST THE HIGHEST SCORE!."; 
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
        case 18:
            return 1; 
            break;            
        case 19:
            return 1; 
            break;            
        case 20:
            return 1; 
            break;            
        default:
            return 0;
            break;
    }        
}

@end
