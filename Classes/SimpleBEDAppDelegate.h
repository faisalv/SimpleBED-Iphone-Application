//
//  hello_iphone_window_dec_29_2010AppDelegate.h
//  hello-iphone-window-dec-29-2010
//
//  Created by faisal on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <vector>
@class MyViewController;

@interface SimpleBEDAppDelegate : NSObject <UIApplicationDelegate, UITabBarDelegate> {
  UIWindow *window;
  UIViewController *viewController;
  UITabBar *tabBar;
  UITabBarItem *bedItem;
  UITabBarItem *percentageItem;
  UITabBarItem *aboutItem;
  
  std::vector<UIViewController*> viewControllers;
}

@property (nonatomic, retain) IBOutlet UIWindow   *window;
@property (nonatomic, retain) IBOutlet UITabBarItem   *bedItem;
@property (nonatomic, retain) IBOutlet UITabBarItem   *percentageItem;
@property (nonatomic, retain) IBOutlet UITabBarItem   *aboutItem;

@property (nonatomic, retain) IBOutlet UITabBar       *tabBar;
@property (nonatomic, retain) UIViewController    *viewController;

//-(IBAction) changePage: (id) sender;

@end

