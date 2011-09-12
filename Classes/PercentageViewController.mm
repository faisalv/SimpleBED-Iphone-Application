//
//  PercentageViewController.m
//  SimpleBEDCalc
//
//  Created by Faisal Vali on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PercentageViewController.h"
#import "BEDController.h"
#import <sstream>
#import <iomanip>
static NSString* new_nsstring(const char* p)
{
  return [[NSString alloc] initWithCString:p encoding: [NSString defaultCStringEncoding]];
}

static const char* new_cstring(NSString* s)
{
  return [s cStringUsingEncoding:[NSString defaultCStringEncoding]];
}


@implementation PercentageViewController
@synthesize webv
            , totalDoseField
            , dosePerFractionField
;


-(void) setBEDController: (BEDController*) vc
{
  bedController = vc;
  //[self updateDoses];
}

-(IBAction) updateDoses: (id) sender
{
  
  double tdose = [bedController getTotalDose];
  double dpf = [bedController getDosePerFraction];
  NSString* tdose_str = [NSString stringWithFormat:@"%.2f", tdose];
  NSString* dpf_str = [NSString stringWithFormat:@"%.2f", dpf];
  totalDoseField.placeholder = tdose_str;
  dosePerFractionField.placeholder = dpf_str;
  
  if (totalDoseField.text.length) {
    tdose = [totalDoseField.text doubleValue];
  }
  if (dosePerFractionField.text.length) {
    dpf = [dosePerFractionField.text doubleValue];
  }
  
  //[tdose_str release];
  
  std::stringstream ss;
  auto add_percentage = ^(std::stringstream& ss, int percentage) 
  { 
    const double p = percentage / 100.0;
    ss << "<tr>";
    ss << "<td class='c"<< percentage << "'>" << percentage << "%</td>";
    ss << "<td>" << tdose * p << "</td>";
    ss << "<td>" << dpf * p << "</td>";
    ss << "</tr>";
  };
  
  ss.setf(std::ios::fixed, std::ios::floatfield);
  ss.precision(2);
  ss << "<html>";
    ss << "<head>";
      ss << "<style type='text/css'>";
        ss << "body {";
            ss << "font-family: helvetica, verdana, arial, sans-serif;";
        ss << "}\n";
        ss << "td, th { font-size: 12pt; }\n";
        //ss << ".c110 { color: red; }\n";
        
      ss << "</style>";
    ss << "</head>";
    ss << "<body bgcolor='#999999'>";
      ss << "<table border cellspacing=2 cellpadding=2 style='margin: 0 auto'>";
        ss << "<tr><th>%</th><th>Total</th><th>Per Fx</th></tr>";
  add_percentage(ss, 120);
  add_percentage(ss, 115);
  add_percentage(ss, 110);
  add_percentage(ss, 107);
  add_percentage(ss, 105);
  add_percentage(ss, 98);
  add_percentage(ss, 95);
  add_percentage(ss, 90);
  add_percentage(ss, 50);
  
  
  
  
  
      ss << "</table>";
    ss << "</body>";
  ss << "</html>";
  NSString* html = new_nsstring(ss.str().c_str());
  [webv loadHTMLString: html  baseURL:nil];
  [html release];
  
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) dealloc
{
  [webv release];
  [totalDoseField release];
  [dosePerFractionField release];
  [super dealloc];
}

@end
