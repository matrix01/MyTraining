//
//  main.m
//  MemoryManagementiOS
//
//  Created by Md. Milan Mia on 9/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarStore.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        /*NSMutableArray *inventory =[[NSMutableArray alloc]init];
        [inventory addObject:@"Honda Civic"];
        NSLog(@"%@", inventory);
        [inventory release];*/
        
        NSMutableArray *inventory = [[NSMutableArray alloc]init];
        [inventory addObject:@"Honda civic"];
        CarStore *superstore = [[CarStore alloc]init];
        [superstore setInventory:inventory];
//        [inventory release];
        
        NSLog(@"%@", [superstore inventory]);
        
    }
    return 0;
}
