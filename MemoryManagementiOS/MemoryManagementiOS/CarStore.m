//
//  CarStore.m
//  MemoryManagementiOS
//
//  Created by Md. Milan Mia on 9/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "CarStore.h"

@implementation CarStore{
    NSMutableArray *_inventory;
}

-(NSMutableArray*) inventory{
    return _inventory;
}
-(void)setInventory:(NSMutableArray *)newInventory{
    //_inventory = [[NSMutableArray alloc] initWithArray:newInventory];
//    _inventory = [newInventory retain];
    _inventory = [newInventory copy];
}
@end
