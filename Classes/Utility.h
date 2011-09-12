//
//  Utility.h
//  SimpleBEDCalc
//
//  Created by Faisal Vali on 9/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string>

namespace fvutil {
  

NSString* string(const char* p);

const char* string(NSString* s);

void MessageBox(const std::string msg, const std::string title = "Alert");
  void MessageBox(NSString* msg, NSString* title = @"Alert");

};