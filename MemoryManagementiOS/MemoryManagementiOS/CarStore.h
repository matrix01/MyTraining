//
//  CarStore.h
//  MemoryManagementiOS
//
//  Created by Md. Milan Mia on 9/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarStore : NSObject
-(NSMutableArray *) inventory;
-(void)setInventory:(NSMutableArray *)newInventory;
@end
