//
//  GameAppDelegate.h
//  Cocos2dManager
//
//  Created by Troy Cox on 1/8/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


#pragma mark GameAppDelegate Class
@interface GameAppDelegate : NSObject <UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UIApplicationDelegate>
{
	UIWindow *window;
}

#pragma mark GameDelegate Methods
// go here!
-(void) authenticateLocalPlayer;

@end
