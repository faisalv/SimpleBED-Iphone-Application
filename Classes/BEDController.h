//
//  MyViewController.h
//  hello-iphone-window-dec-29-2010
//
//  Created by faisal on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <vector>
//#include <boost/array.hpp>

@interface BEDController : UIViewController<UITextFieldDelegate> {
  UITextField *dpfField;  // enter dose per fraction
  UIButton* dpfButton;    // toggle dose per fraction
  UITextField *nofField;  // enter number of treatments
  UIButton* nofButton;    // toggle number of fractions
  //UITextField *tdField;   // 
  UILabel *tdTitleLabel;  // contains the Total Dose title
  UILabel *tdLabel;       // contains the Total Dose (toggles btw DPF, or NOF vs TD)
  
  
  UITextField *eqDoseField;  // enter desired equivalent dose  - starts at 2Gy usually
  UITextField *earlyABField; // enter early alpha-beta - tumor - starts at 10
  UITextField *lateABField;  // enter late alpha-beta - organs - starts at 3

  UILabel *earlyLabelTitle;  // the label for early alpha-beta (to allow greek characters)
  UILabel *lateLabelTitle;

  UILabel *earlyLabel;  // contains the early Equivalent Dose result
  UILabel *lateLabel;   // contains the late Equivalent Dose result
  
  
  UILabel *earlyBEDLabel; // contains the early BED Dose result
  UILabel *lateBEDLabel;  // contains the late BED Dose result
  
  UILabel *earlyDoseLabelTitle;  // the label next to the actual dose calcs Early (a/b)
  UILabel *lateDoseLabelTitle;   // the label next to the actual late dose calcs
  
  double eqDose;
  double earlyAB;
  double lateAB;
  
}

@property (nonatomic, retain) IBOutlet UITextField *dpfField;
@property (nonatomic, retain) IBOutlet UIButton *dpfButton;

@property (nonatomic, retain) IBOutlet UITextField *nofField;
@property (nonatomic, retain) IBOutlet UIButton *nofButton;

@property (nonatomic, retain) IBOutlet UILabel  *tdTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel  *tdLabel;

//@property (nonatomic, retain) IBOutlet UITextField *tdField;

@property (nonatomic, retain) IBOutlet UITextField *eqDoseField;

@property (nonatomic, retain) IBOutlet UITextField *earlyABField;
@property (nonatomic, retain) IBOutlet UITextField *lateABField;




@property (nonatomic, retain) IBOutlet UILabel  *earlyLabel;
@property (nonatomic, retain) IBOutlet UILabel  *lateLabel;
@property (nonatomic, retain) IBOutlet UILabel  *earlyBEDLabel;
@property (nonatomic, retain) IBOutlet UILabel  *lateBEDLabel;
@property (nonatomic, retain) IBOutlet UILabel  *earlyLabelTitle;
@property (nonatomic, retain) IBOutlet UILabel  *lateLabelTitle;

@property (nonatomic, retain) IBOutlet UILabel  *earlyDoseLabelTitle;
@property (nonatomic, retain) IBOutlet UILabel  *lateDoseLabelTitle;

//@property (nonatomic, retain) UIScrollView  *scrollView;

-(IBAction) updateAllFields: (UITextField*) sender;
-(IBAction) changedEquivalentDoseField: (UITextField*) sender;
-(IBAction) changedEarlyABField: (UITextField*) sender;
-(IBAction) changedLateABField: (UITextField*) sender;
-(IBAction) toggleDPFButton:(id)sender;
-(IBAction) toggleNOFButton:(id)sender;
-(IBAction) resetView:(id)sender; 

-(double) getTotalDose;
-(double) getDosePerFraction;
-(IBAction) textFieldDidBeginEditing:(UITextField *)sender;
//-(IBAction) textFieldDidEndEditing:(UITextField *)sender;

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp;
//-(IBAction) updateFieldFocusChanged : (UITextField*) sender;
//-(IBAction) focusLost : (UITextField*) sender;
//-(IBAction) focusGained : (UITextField*) sender;

@end
