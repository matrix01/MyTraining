//
//  PrimeFinder.m
//  Concurrency
//
//  Created by Md. Milan Mia on 10/28/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "PrimeFinder.h"

@interface PrimeFinder()
@property NSInteger completed;
@property NSInteger maxNumber;
@property (nonatomic, strong) NSOperationQueue *primeQ;
@property (nonatomic, readwrite) NSDate *startDate;
@property (nonatomic, readwrite) NSDate *endDate;
@end

@implementation PrimeFinder

-(id)initWithMaximumNumber:(NSInteger)maxNumber {
    self = [super self];
    if(self){
        _maxNumber = maxNumber;
        _primeQ = [NSOperationQueue new];
        _primes = [@[] mutableCopy];
    }
    return self;
}
-(BOOL) checkNumberIsPrime:(NSInteger)number {
    for (NSInteger n=2; n<number; n++) {
        if(number %n == 0)
            return NO;
    }
    return YES;
}
-(void)start {
    NSLog(@"Start findings: ");
    [self setStartDate:[NSDate date]];
    
    for (NSInteger number=2; number<_maxNumber; number++) {
        
        NSBlockOperation *primeFindingsOperation = [NSBlockOperation blockOperationWithBlock:^{
        
            if([self checkNumberIsPrime:number]){
                @synchronized(self){
                    [_primes addObject:[NSNumber numberWithInteger:number]];
                }
            }
            
        }];
        
        primeFindingsOperation.completionBlock = ^(void){
            @synchronized(self){
                [self setEndDate:[NSDate date]];
            }
        };
        
        [_primeQ addOperation:primeFindingsOperation];
    }
}
-(NSTimeInterval)elapsedTime {
    return [self.endDate timeIntervalSinceDate:self.startDate];
}
-(BOOL)finished {
    return ([self.primeQ operationCount]==0);
}
@end