//
//  Store.m
//  PhoneBook
//
//  Created by Md. Milan Mia on 9/22/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Store.h"
#import "Courses.h"
@implementation Store
@synthesize phoneBook;

+(instancetype)sharedStore{
    static Store *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
-(instancetype)initPrivate{
    self =[super init];
    phoneBook = [[NSMutableArray alloc]init];
    return self;
}
-(id)init{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[Store sharedStore]"
                                 userInfo:nil];
    return nil;
}
-(NSMutableArray*)getItems{
    return [phoneBook copy];
}
-(void)deleteItem:(NSInteger)indexNo {
    [phoneBook removeObjectAtIndex:indexNo];
}
@end
