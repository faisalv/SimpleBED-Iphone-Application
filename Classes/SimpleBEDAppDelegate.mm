//
//  hello_iphone_window_dec_29_2010AppDelegate.m
//  hello-iphone-window-dec-29-2010
//
//  Created by faisal on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SimpleBEDAppDelegate.h"
#import "BEDController.h"
#import "PercentageViewController.h"
#import "AboutViewController.h"
#include "Utility.h"
#include <string>
#include <vector>

@implementation SimpleBEDAppDelegate

@synthesize window
            , viewController
            , bedItem
            , percentageItem
            , tabBar
            , aboutItem
          //  , pageController
            ;


#pragma mark -
#pragma mark Application lifecycle
/*
static NSString* new_nsstring(const char* p)
{
  return [[NSString alloc] initWithCString:p encoding: [NSString defaultCStringEncoding]];
}

static const char* new_cstring(NSString* s)
{
  return [s cStringUsingEncoding:[NSString defaultCStringEncoding]];
}


static void MessageBox(const std::string msg, const std::string title = "Alert")
{
  
  NSString* title_ = new_nsstring(title.c_str());
  NSString* msg_ = new_nsstring(msg.c_str());
  
  UIAlertView *alt = [[UIAlertView alloc] initWithTitle: title_ message: msg_ delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
  
  [title_ release];
  [msg_ release];
  
  [alt show];
  
  [alt release];
  
}
static void MessageBox(NSString* msg, NSString* title = @"Alert")
{
  
  NSString* title_ = title;
  NSString* msg_ = msg;
  
  UIAlertView *alt = [[UIAlertView alloc] initWithTitle: title_ message: msg_ delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
  
  [title_ release];
  [msg_ release];
  
  [alt show];
  
  [alt release];
  
}
*/

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  //fvutil::MessageBox("didSelectItemSelected");
  int pageNum = 0;
  if (item == bedItem)
  {
    pageNum = 0;
  }
  else if (item == percentageItem)
  {
    pageNum = 1;
  }
  else if (item == aboutItem)
    pageNum = 2;
  
  UIViewController* newvc = viewControllers[pageNum];
  [self.viewController.view removeFromSuperview];
  self.viewController = newvc;
  [self.window addSubview:newvc.view];
  
  if (pageNum == 1) {
    [(PercentageViewController*)newvc updateDoses: nil];
  }
  //MessageBox(self.bedItem.title);
  //self.tabBar.selectedItem = nil;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
  
  /*
  CGRect wholeWindow = [[self window] bounds];
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:wholeWindow];
  //[[self window] addSubview:scrollView];
  
  // Make your view twice as large as the window
  CGRect reallyBigRect;
  reallyBigRect.origin = CGPointZero;
  reallyBigRect.size.width = wholeWindow.size.width * 2.0;
  reallyBigRect.size.height = wholeWindow.size.height * 2.0;
  //[scrollView setContentSize:reallyBigRect.size];
  
  // Center it in the scroll view
  CGPoint offset;
  offset.x = wholeWindow.size.width * 0.5;
  offset.y = wholeWindow.size.height * 0.5;
  [scrollView setContentOffset:offset];
  */
    
  auto bedvc = [[BEDController alloc] 
                            initWithNibName:@"MyViewController" bundle:[NSBundle mainBundle]];

  auto percvc = [[PercentageViewController alloc] 
                          initWithNibName:@"PercentageViewController" bundle:[NSBundle mainBundle]];
  [percvc setBEDController:bedvc];
  
  auto aboutvc = [[AboutViewController alloc]
              initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
  
  self.viewController = bedvc;
  
  viewControllers.push_back(bedvc);
  viewControllers.push_back(percvc);
  viewControllers.push_back(aboutvc);
  
  //CGRect wholeWindow = [self.window bounds];
  //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:wholeWindow];
  //[self.window addSubview:scrollView]; 
  
  //[scrollView addSubview: self.viewController.view];
  //[scrollView release];
  //[scrollView addSubview:self.viewController.view];
  
  //[self.window addSubview:scrollView];
  [self.window addSubview:self.viewController.view];
  [self.window makeKeyAndVisible];
  //self.tabBar.selectedItem = bedItem;
  self.tabBar.selectedItem = nil;
  self.tabBar.selectedItem = bedItem;
  //MessageBox(self.bedItem.title);
  //MessageBox("ApplicationDidLaunch");
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
  [window release];
  [bedItem release];
  [percentageItem release];
  [tabBar release];
  [viewController release];
  for (auto vc : viewControllers )
  {
    [vc release];
  }
  
  [super dealloc];
}


@end
