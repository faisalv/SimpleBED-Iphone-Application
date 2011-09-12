//
//  MyViewController.mm
//  hello-iphone-window-dec-29-2010
//
//  Created by faisal on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BEDController.h"
//#import <boost/regex.hpp>
//#import <boost/wave.hpp>
#import <string>
#import <sstream>
#import <vector>
#import <map>
#include "Utility.h"


NSString* DOSE_PER_FRACTION_STR =   @"Dose Per Fraction (Gy)";
NSString* NUMBER_OF_FRACTIONS_STR = @"Number Of Fractions";
NSString* TOTAL_DOSE_STR = @"Total Dose (Gy)";


//#import <boost/program_options.hpp>

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
*/
@implementation BEDController

@synthesize dpfField
            , dpfButton
            , nofField
            , nofButton
            , tdLabel
            , tdTitleLabel
         //   , tdField
            , eqDoseField
            , earlyLabel
            , lateLabel
            , earlyBEDLabel
            , lateBEDLabel
            , earlyLabelTitle
            , lateLabelTitle
            , earlyDoseLabelTitle
            , lateDoseLabelTitle
            , earlyABField
            , lateABField
;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  eqDose = earlyAB = lateAB = 0.0;
  
  return self;
}


bool is_dose_per_fraction(UIButton* btn)
{
  bool ret = [btn.currentTitle isEqualToString:DOSE_PER_FRACTION_STR];
  return ret;
}
bool is_total_dose(UIButton* btn)
{
  bool ret = [btn.currentTitle isEqualToString:TOTAL_DOSE_STR];
  return ret;
}
bool is_number_of_fractions(UIButton* btn)
{
  bool ret = [btn.currentTitle isEqualToString:NUMBER_OF_FRACTIONS_STR];
  return ret;
}

-(IBAction) toggleDPFButton:(id)sender
{
  // we can not have both be toggled
  if (!is_number_of_fractions(self.nofButton))
    [self toggleNOFButton:nofButton];
  //double dpf = 0, td = 0;
  if (is_dose_per_fraction(dpfButton) )
  {
    [dpfButton setTitle:TOTAL_DOSE_STR forState:UIControlStateNormal];
    tdTitleLabel.text = DOSE_PER_FRACTION_STR;
    //dpf = [dpfField.text doubleValue];
    //td = [tdLabel.text doubleValue];
    //dpfField.text = [NSString stringWithFormat:@"%.2f", td];
    //tdLabel.text = [NSString stringWithFormat:@"%.2f", dpf];
  } 
  else
  {
    [dpfButton setTitle:DOSE_PER_FRACTION_STR forState:UIControlStateNormal];
    tdTitleLabel.text = TOTAL_DOSE_STR;
    //td = [dpfField.text doubleValue];
    //dpf = [tdLabel.text doubleValue];
    //tdLabel.text = [NSString stringWithFormat:@"%.2f", td];
    //dpfField.text = [NSString stringWithFormat:@"%.2f", dpf];
  }
  //dpfField.text = @"";
  //tdLabel.text = @"0.00";
  NSString* tmp = dpfField.text;
  dpfField.text = tdLabel.text;
  tdLabel.text = tmp;
  //MessageBox("Test-1");
  //[self updateAllFields:NULL];
}

-(IBAction) toggleNOFButton:(id)sender
{
  // we can not have both be toggled
  if (!is_dose_per_fraction(self.dpfButton))
    [self toggleDPFButton:dpfButton];
  //double nof = 0, td = 0;
  if (is_number_of_fractions(nofButton) )
  {
    [nofButton setTitle:TOTAL_DOSE_STR forState:UIControlStateNormal];
    tdTitleLabel.text = NUMBER_OF_FRACTIONS_STR;
    //nof = [nofField.text doubleValue];
    //td = [tdLabel.text doubleValue];
    //nofField.text = [NSString stringWithFormat:@"%.2f", td];
    //tdLabel.text = [NSString stringWithFormat:@"%.2f", nof];
    
  } 
  else
  {
    [nofButton setTitle:NUMBER_OF_FRACTIONS_STR forState:UIControlStateNormal];
    tdTitleLabel.text = TOTAL_DOSE_STR;
    //td = [nofField.text doubleValue];
    //nof = [tdLabel.text doubleValue];
    //tdLabel.text = [NSString stringWithFormat:@"%.2f", td];
    //nofField.text = [NSString stringWithFormat:@"%.2f", nof];
    //NSString* tmp = nofField.text;
    
  }
  //nofField.text = @"";
  //tdLabel.text = @"0.00";
  NSString* tmp = nofField.text;
  nofField.text = tdLabel.text;
  tdLabel.text = tmp;
  
  //[self updateAllFields:NULL];
}


-(IBAction) resetView: (id)sender {
  eqDoseField.text = @"2";
  eqDose = 2;
  
  earlyABField.text = @"10";
  earlyAB = 10;
  
  lateABField.text = @"3";
  lateAB = 3;
  
  tdLabel.text = @"0"; // The total dose
  nofField.text = @"";
  dpfField.text = @"";
  
  [dpfButton setTitle:DOSE_PER_FRACTION_STR forState:UIControlStateNormal];
  [nofButton setTitle:NUMBER_OF_FRACTIONS_STR forState:UIControlStateNormal];
  tdTitleLabel.text = TOTAL_DOSE_STR;
  
  [self updateAllFields:0];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  [dpfField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
  [nofField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
  self.earlyLabelTitle.text = @"Early \u03B1/\u03B2"; 
  self.lateLabelTitle.text = @"Late \u03B1/\u03B2"; 
  //eqDose = [eqDoseField.text doubleValue];
  //earlyAB = [earlyABField.text doubleValue];
  //lateAB = [lateABField.text doubleValue];
  [self resetView:NULL];
  //MessageBox("ViewDidLoad");
  //[self parentViewController]
  // register for keyboard notifications
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
  return NO;
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
  
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  // unregister for keyboard notifications while not visible.
//  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 

}


- (void)dealloc {
  
  [dpfField release];
  [dpfButton release];
  [nofField release];
  [nofButton release];
  [tdLabel release];
  [tdTitleLabel release];
  [eqDoseField release];
  [earlyABField release];
  [lateABField release];
  
  [earlyLabel release];
  [lateLabel release];
  [earlyBEDLabel release];
  [lateBEDLabel release];
  [earlyLabelTitle release];
  [earlyDoseLabelTitle release];
  [lateDoseLabelTitle release];
  //MessageBox("dalloc called");
  [super dealloc];
}

-(IBAction)changedEquivalentDoseField:(UITextField *)sender {
  eqDose = [sender.text doubleValue];
  [self updateAllFields:sender];
}
-(IBAction) changedEarlyABField: (UITextField*) sender {
  /*
  auto senderText = sender.text;
  auto other = sender == earlyABField ? earlyABField : earlyABField;
  auto otherText = other.text;
  if ( ![senderText isEqualToString:otherText] )
  {
    other.text = senderText;
  }
   */
  earlyAB = [sender.text doubleValue];
  [self updateAllFields:sender ];

}
-(IBAction) changedLateABField: (UITextField*) sender {
  lateAB = [sender.text doubleValue];
  [self updateAllFields:sender ];
  
}

-(double) getTotalDose
{
  
  [self updateAllFields:nil]; // update the doses
  double tdose = 0;
  
  // now figure out which box holds the total dose
  if (!is_number_of_fractions(nofButton)) {
    tdose = [nofField.text doubleValue];
  }
  else if (!is_dose_per_fraction(dpfButton)) {
    tdose = [dpfField.text doubleValue];
  }
  else
  {
    tdose = [tdLabel.text doubleValue]; 
  }
  return tdose;
  
}
-(double) getDosePerFraction
{
  
  [self updateAllFields:nil]; // update the doses
  double dpf = 0;
  
  // now figure out which box holds the total dose
  if (is_dose_per_fraction(dpfButton)) {
    dpf = [dpfField.text doubleValue];
  }
  else
  {
    dpf = [tdLabel.text doubleValue]; 
  }
  return dpf;
}


-(IBAction) updateAllFields: (UITextField*) sender {
  
  double nof = 0, dpf = 0, td = 0;
  bool set_td = false;
  if (is_number_of_fractions(nofButton)) {
    nof = [nofField.text doubleValue];
  }
  else
  {
    td = [nofField.text doubleValue];
    set_td = true;
  }
  
  assert(is_dose_per_fraction(dpfButton) || is_number_of_fractions(nofButton));
 
  if (is_dose_per_fraction(dpfButton)) {
    dpf = [dpfField.text doubleValue];
  }
  else
  {
    td = [dpfField.text doubleValue];
    set_td = true;
  }
  if (!set_td)
    td = nof * dpf;
  else
  {
    if (!nof && dpf) nof = td/dpf;
    if (!dpf && nof) dpf = td/nof;
  }
  //double (^fid)(double) = ^double (double d) { return d + nof - dpf - nof + dpf; };

  // the value to be placed inside the tdValue - this depends on the toggle
  // tdVal is not always the total dose
  double tdVal = td; //nofVal = nof, dpfVal = dpf;
  if (!is_dose_per_fraction(dpfButton)) {
    tdVal = dpf;
    //dpfVal = td;
  }
  if (!is_number_of_fractions(nofButton)) {
    tdVal = nof;
    //nofVal = td;
  }
  
  //if (self.tdLabel.text.length > 0 || tdVal )
  {
    int f = (int) floor(tdVal);
    int c = (int) ceil(tdVal);
    // if it is aninteger   
    if (f != c)
      self.tdLabel.text = [NSString stringWithFormat:@"%.2f", tdVal];
    else
      self.tdLabel.text = [NSString stringWithFormat:@"%.0f", tdVal];

  }
  const double EARLY_ALPHA_BETA = earlyAB;
  const double LATE_ALPHA_BETA = lateAB;
  const double NEW_DPF = eqDose;
  
  double early_bed = dpf * nof * (1 + dpf/EARLY_ALPHA_BETA);
  double late_bed = dpf * nof * (1 + dpf/LATE_ALPHA_BETA);
   
  double early_lqed = (NEW_DPF * early_bed)/(NEW_DPF * (1 + NEW_DPF/EARLY_ALPHA_BETA));
  double late_lqed =  (NEW_DPF * late_bed)/(NEW_DPF * (1 + NEW_DPF/LATE_ALPHA_BETA));
  if ( isnan(early_lqed) || isnan(late_lqed) || isnan(late_bed) || isnan(early_bed) )
      early_lqed = late_lqed = late_bed = early_bed = 0.0;
  
  self.earlyLabel.text = [NSString stringWithFormat:@"%.2f", early_lqed];
  self.lateLabel.text = [NSString stringWithFormat:@"%.2f", late_lqed];
  self.earlyBEDLabel.text = [NSString stringWithFormat:@"%.2f", early_bed];
  self.lateBEDLabel.text = [NSString stringWithFormat:@"%.2f", late_bed];
  
  
}

// Allow the keyboard to disappear
- (BOOL)textFieldShouldReturn:(UITextField *)curField {
  [curField resignFirstResponder];
  return YES;
  
}

// Ensure we can only type numbers
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)typed_str
{
  
  NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:typed_str];
    
  NSString *remnants = [newString 
                        stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
                        
  return ([remnants isEqualToString:@""] || [remnants isEqualToString:@"."]);
  }
//-----------------------------------------------
//amount to move view up
#define kOFFSET_FOR_KEYBOARD 140.0

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
  // here is where we decide to move view up for certain textfields
  if ([sender isEqual:lateABField] or [sender isEqual:earlyABField])
  {
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
      [self setViewMovedUp:YES];
    }
  }
}
/*
-(void)textFieldDidEndEditing:(UITextField *)sender
{
  // here is where we decide to move view up for certain textfields
  if ([sender isEqual:sender])
  {
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
      [self setViewMovedUp:NO];
    }
  }
}
 */


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5]; // if you want to slide up the view
  
  CGRect rect = self.view.frame;
  if (movedUp)
  {
    // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
    // 2. increase the size of the view so that the area behind the keyboard is covered up.
    rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    rect.size.height += kOFFSET_FOR_KEYBOARD;
  }
  else
  {
    // revert back to the normal state.
    rect.origin.y += kOFFSET_FOR_KEYBOARD;
    rect.size.height -= kOFFSET_FOR_KEYBOARD;
  }
  self.view.frame = rect;
  
  [UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
  //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
  static bool B = false;
  if (![lateABField isFirstResponder] and ![earlyABField isFirstResponder]) return;  
  if (self.view.frame.origin.y >= 0)//!B)//([_textField isFirstResponder] && self.view.frame.origin.y >= 0)
  //if ([lateABField isFirstResponder] && self.view.frame.origin.y >= 0)
  {
    [self setViewMovedUp:YES];
    B=true;
  }
  /*
  else if (self.view.frame.origin.y < 0) //B)//(![_textField isFirstResponder] && self.view.frame.origin.y < 0)
  //else if (![lateABField isFirstResponder] && self.view.frame.origin.y < 0)
  {
    [self setViewMovedUp:NO];
    B=false;
  }
   */
}
- (void)keyboardWillHide:(NSNotification *)notif
{
  //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
  static bool B = false;
  /*
  if (self.view.frame.origin.y >= 0)//!B)//([_textField isFirstResponder] && self.view.frame.origin.y >= 0)
    //if ([lateABField isFirstResponder] && self.view.frame.origin.y >= 0)
  {
    [self setViewMovedUp:YES];
    B=true;
  }
  else 
  */
  if (self.view.frame.origin.y < 0) //B)//(![_textField isFirstResponder] && self.view.frame.origin.y < 0)
    //else if (![lateABField isFirstResponder] && self.view.frame.origin.y < 0)
  {
    [self setViewMovedUp:NO];
    B=false;
  }
}



- (void)viewWillAppear:(BOOL)animated
{
  // register for keyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                               name:UIKeyboardWillShowNotification object:self.view.window];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) 
                                               name:UIKeyboardWillHideNotification object:self.view.window]; 

}

- (void)viewWillDisappear:(BOOL)animated
{
  // unregister for keyboard notifications while not visible.
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

@end
