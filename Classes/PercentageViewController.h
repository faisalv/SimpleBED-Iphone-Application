//
//  PercentageViewController.h
//  SimpleBEDCalc
//
//  Created by Faisal Vali on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BEDController;
@interface PercentageViewController : UIViewController<UITextFieldDelegate> {
  BEDController* bedController;
  IBOutlet UILabel* pageTitleLabel;
  UITextField* totalDoseField;
  UITextField* dosePerFractionField;
  
  UIWebView *webv;
  
  
  
  
}
@property (nonatomic, retain) IBOutlet UIWebView   *webv;
@property (nonatomic, retain) IBOutlet UITextField *totalDoseField;
@property (nonatomic, retain) IBOutlet UITextField   *dosePerFractionField;

-(void) setBEDController: (BEDController*) vc;
-(IBAction) updateDoses: (id) sende;
@end
