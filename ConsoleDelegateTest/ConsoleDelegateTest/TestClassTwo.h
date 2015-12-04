//
//  TestClassTwo.h
//  ConsoleDelegateTest
//
//  Created by Md. Milan Mia on 9/18/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"
@interface TestClassTwo : NSObject<CustomProtocol>

@property(nonatomic, weak)id <CustomProtocol> myDelegateOne;

@end
