//
//  Score.h
//  AngryGunner
//
//  Created by Troy Cox on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>

@interface Score : CCLayer<GKLeaderboardViewControllerDelegate>
{
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;
- (void) menuItemLeaderBoardClicked:(id)sender;
- (void)achievementBoard;
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController;
- (void) reportScore;
-(UIViewController*) getRootViewController; 


@end

