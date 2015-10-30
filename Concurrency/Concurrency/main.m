//
//  main.m
//  Concurrency
//
//  Created by Md. Milan Mia on 10/28/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PrimeFinder.h"
void WAIT_UNTIL(BOOL condition, int maxWait){
    int WAIT_UNTIL_N= 0;
    while(!condition && WAIT_UNTIL_N<maxWait){
        WAIT_UNTIL_N++;
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PrimeFinder *pf = [[PrimeFinder alloc]initWithMaximumNumber:50000];
        [pf start];
        WAIT_UNTIL([pf finished], 120);
        NSLog(@"%@", pf.primes);
        NSLog (@"Found all prime number in %f sec", [pf elapsedTime]);
        
    }
    return 0;
}
