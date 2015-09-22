//
//  TestClassOne.h
//  ConsoleDelegateTest
//
//  Created by Md. Milan Mia on 9/18/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"
@interface TestClassOne : NSObject<CustomProtocol>

@property(nonatomic, weak)id <CustomProtocol> myDelegate;

@end
