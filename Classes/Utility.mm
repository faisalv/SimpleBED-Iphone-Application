//
//  Utility.m
//  SimpleBEDCalc
//
//  Created by Faisal Vali on 9/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import <string>
namespace fvutil
{

NSString* string(const char* p)
{
  return [[[NSString alloc] 
            initWithCString:p 
            encoding: [NSString defaultCStringEncoding]
        ] autorelease];
}

const char* string(NSString* s)
{
  return [s cStringUsingEncoding:[NSString defaultCStringEncoding]];
}

void MessageBox(const std::string msg, const std::string title)
{
  
  NSString* title_ = string(title.c_str());
  NSString* msg_ = string(msg.c_str());
  
  UIAlertView *alt = [[UIAlertView alloc] initWithTitle: title_ message: msg_ delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
  
  [title_ release];
  [msg_ release];
  
  [alt show];
  
  [alt release];
}

  void MessageBox(NSString* msg, NSString* title)
  {
    
    NSString* title_ = title;
    NSString* msg_ = msg;
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle: title_ message: msg_ delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    
    [title_ release];
    [msg_ release];
    
    [alt show];
    
    [alt release];
    
  }

  
} // end namespace fv

