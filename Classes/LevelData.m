//
//  LevelData.m
//  The Drop
//
//  Created by Troy Cox on 1/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelData.h"
#import "SynthesizeSingleton.h"

@implementation LevelData 

@synthesize score;
@synthesize highScore;
@synthesize useGameCenter;
@synthesize difficultOn;
@synthesize torpedoesOn;
@synthesize shouldPlaySfx;

SYNTHESIZE_SINGLETON_FOR_CLASS(LevelData);



- (id)init {
	if((self = [super init])) {
		
		[LevelData loadState];
				
		if (self.highScore==0) {
			[self setScore:0];
			[self setHighScore:0];
			[self setUseGameCenter:FALSE];
			[self setDifficultOn:FALSE];
			[self setTorpedoesOn:FALSE];
			[self setShouldPlaySfx:TRUE];
			[LevelData saveState];
		}
		
	}
	return self;
}


+(void)loadState
{
	@synchronized([LevelData class]) {
		// just in case loadState is called before GameState inits
		if(!sharedLevelData)
			[LevelData sharedLevelData] ;
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		
		sharedLevelData.score = [prefs integerForKey:@"score"];
		sharedLevelData.highScore = [prefs integerForKey:@"highScore"];
		sharedLevelData.useGameCenter = [prefs boolForKey:@"useGameCenter"];
		sharedLevelData.difficultOn = [prefs boolForKey:@"difficultOn"];
		sharedLevelData.torpedoesOn = [prefs boolForKey:@"torpedoesOn"];
		sharedLevelData.shouldPlaySfx = [prefs boolForKey:@"shouldPlaySfx"];
		[prefs synchronize];
						
	}
	
}

+(void)saveState
{
	@synchronized([LevelData class]) {  
		
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		
		// saving an NSString		
		[prefs setInteger: sharedLevelData.score forKey:@"score"];
		[prefs setInteger: sharedLevelData.highScore forKey:@"highScore"];
		[prefs setBool: sharedLevelData.useGameCenter forKey:@"useGameCenter"];
		[prefs setBool: sharedLevelData.difficultOn forKey:@"difficultOn"];
		[prefs setBool: sharedLevelData.torpedoesOn forKey:@"torpedoesOn"];
		[prefs setBool: sharedLevelData.shouldPlaySfx forKey:@"shouldPlaySfx"];
		
		// This is suggested to synch prefs, but is not needed (I didn't put it in my tut)
		[prefs synchronize];
		
	}
}

@end

