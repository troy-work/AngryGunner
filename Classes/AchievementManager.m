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
            return @"\nMISSION: SEAMAN APPRENTICE"; 
            break;            
        case 2:
            return @"\nMISSION: SEAMAN"; 
            break;            
        case 3:
            return @"\nPETTY OFFICER THIRD CLASS"; 
            break;            
        case 4:
            return @"\nPETTY OFFICER SECOND CLASS"; 
            break;            
        case 5:
            return @"\nPETTY OFFICER FIRST CLASS"; 
            break;            
        case 6:
            return @"\nCHIEF PETTY OFFICER"; 
            break;            
        case 7:
            return @"\nSENIOR CHIEF PETTY OFFICER"; 
            break;            
        case 8:
            return @"\nMASTER CHIEF PETTY OFFICER"; 
            break;            
        case 9:
            return @"\nMASTER CHIEF PETTY OFFICER OF THE NAVY"; 
            break;            
        case 10:
            return @"\nENSIGN"; 
            break;            
        case 11:
            return @"\nLIEUTENANT JUNIOR GRADE"; 
            break;            
        case 12:
            return @"\nLIEUTENANT"; 
            break;            
        case 13:
            return @"\nLIEUTENANT COMMANDER"; 
            break;            
        case 14:
            return @"\nCOMMANDER"; 
            break;            
        case 15:
            return @"\nCAPTAIN"; 
            break;            
        case 16:
            return @"\nREAR ADMIRAL (LOWER HALF)"; 
            break;            
        case 17:
            return @"\nREAR ADMIRAL (UPPER HALF)"; 
            break;            
        case 18:
            return @"\nVICE ADMIRAL"; 
            break;            
        case 19:
            return @"\nADMIRAL"; 
            break;            
        case 20:
            return @"\nFLEET ADMIRAL"; 
            break;            
        default:
            return @"";
            break;
    }
}


+(NSString *)getCurrentTitleByMultiplier:(int) multiplier
{
    switch (multiplier-1) {
        case 0:
            return @"\nRANK: SEAMAN RECRUIT"; 
            break;                        
        case 1:
            return @"\nRANK: SEAMAN APPRENTICE"; 
            break;            
        case 2:
            return @"\nRANK: SEAMAN"; 
            break;            
        case 3:
            return @"\nRANK: PETTY OFFICER THIRD CLASS"; 
            break;            
        case 4:
            return @"\nRANK: PETTY OFFICER SECOND CLASS"; 
            break;            
        case 5:
            return @"\nRANK: PETTY OFFICER FIRST CLASS"; 
            break;            
        case 6:
            return @"\nRANK: CHIEF PETTY OFFICER"; 
            break;            
        case 7:
            return @"\nRANK: SENIOR CHIEF PETTY OFFICER"; 
            break;            
        case 8:
            return @"\nRANK: MASTER CHIEF PETTY OFFICER"; 
            break;            
        case 9:
            return @"\nRANK: MASTER CHIEF PETTY OFFICER OF THE NAVY"; 
            break;            
        case 10:
            return @"\nRANK: ENSIGN"; 
            break;            
        case 11:
            return @"\nRANK: LIEUTENANT JUNIOR GRADE"; 
            break;            
        case 12:
            return @"\nRANK: LIEUTENANT"; 
            break;            
        case 13:
            return @"\nRANK: LIEUTENANT COMMANDER"; 
            break;            
        case 14:
            return @"\nRANK: COMMANDER"; 
            break;            
        case 15:
            return @"\nRANK: CAPTAIN"; 
            break;            
        case 16:
            return @"\nRANK: REAR ADMIRAL (LOWER HALF)"; 
            break;            
        case 17:
            return @"\nRANK: REAR ADMIRAL (UPPER HALF)"; 
            break;            
        case 18:
            return @"\nRANK: VICE ADMIRAL"; 
            break;            
        case 19:
            return @"\nRANK: ADMIRAL"; 
            break;            
        case 20:
            return @"\nRANK: FLEET ADMIRAL"; 
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
            return @"\nFOR SEAMAN APPRENTICE YOU NEED TO KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 2:
            return @"\nFOR SEAMAN NO TORPEDOES CAN HIT YOU BEFORE YOU KILL 3 FIGHTERS AFTER THEY LEVEL OFF FROM THEIR DIVE AND BEFORE THEY TURN RIGHT OR LEFT"; 
            break;            
        case 3:
            return @"\nFOR PETTY OFFICER THIRD CLASS YOU NEED TO SCORE OVER 14000 ALL IN LEVEL 1"; 
            break;            
        case 4:
            return @"\nFOR PETTY OFFICER SECOND CLASS YOU NEED TO STAY ALIVE UNTIL LEVEL 3"; 
            break;            
        case 5:
            return @"\nFOR PETTY OFFICER FIRST CLASS YOU NEED TO STAY ALIVE UNTIL LEVEL 3. BUT, THIS TIME WITHOUT A TORPEDO HIT!"; 
            break;            
        case 6:
            return @"\nFOR CHIEF PETTY OFFICER YOU CAN'T ALLOW A SINGLE TORPEDO PLANE TO ESCAPE IN ALL OF LEVEL 1."; 
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
            return @"\nPROVE YOUR SKILL. FOR ENSIGN, YOU MUST SCORE MORE THAN 50000 IN LEVEL 1."; 
            break;            
        case 11:
            return @"\nTIME FOR BIG SCORE AND SHARP SHOOTING. FOR LIEUTENANT JUNIOR GRADE KILL A TORPEDO PLANE AFTER IT DROPS THE TORPEDO AND IS CLIMBING AWAY."; 
            break;            
        case 12:
            return @"\nEASY MONEY. FOR LIEUTENANT, KILL EVERY PLANE AND NEVER GET HIT WITH A TORPEDO FOR ALL OF LEVEL 1."; 
            break;            
        case 13:
            return @"\nFOR LIEUTENANT COMMANDER, KILL A FIGHTER DODGING TO YOUR LEFT."; 
            break;            
        case 14:
            return @"\nFOR COMMANDER, KILL EVERY FIGHTER DODGING TO YOUR LEFT FOR ALL OF LEVEL 1."; 
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
            return @"\nFOR VICE ADMIRAL, "; 
            break;            
        case 19:
            return @"\nFOR ADMIRAL, "; 
            break;            
        case 20:
            return @"\nFINALLY, FLEET ADMIRAL, "; 
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
