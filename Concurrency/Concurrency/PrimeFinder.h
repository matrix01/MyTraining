//
//  PrimeFinder.h
//  Concurrency
//
//  Created by Md. Milan Mia on 10/28/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeFinder : NSObject
@property (nonatomic, strong) NSMutableArray *primes;

-(BOOL)finished;
-(id)initWithMaximumNumber:(NSInteger) maxNumber;
-(void)start;
-(NSTimeInterval)elapsedTime;
@end
