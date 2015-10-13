//
//  Store.m
//  PhoneBookApplication
//
//  Created by Md. Milan Mia on 10/6/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Store.h"
#import "Person.h"
#import <UIKit/UIKit.h>

@implementation Store
@synthesize phoneBook;

+(instancetype)sharedStore{
    static Store *sharedStore;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
        [[Store sharedStore] createItems];
        [[Store sharedStore]sortAndGroupBy];
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
-(void)createItems{
    for(int i=-5; i<=10; i++){
        Person *person = [[Person alloc]init];
        person.name = [NSString stringWithFormat:@"Name %d", i];
        person.phoneNo = [[NSMutableArray alloc]init];
        [person.phoneNo addObject:[NSString stringWithFormat:@"%d%d%d%d%d", i, i, i, i, i]];
        person.email = [NSString stringWithFormat:@"xyz@%d.com", i];
        person.image = [UIImage imageNamed:@"contact"];
        person.Id = [[NSMutableArray alloc]init];
        [person.Id addObject:[NSString stringWithFormat:@"Id %d", i ]];
        [self.phoneBook addObject:person];
    }
}
-(void)sortAndGroupBy{
    NSArray *sortedArray;
    sortedArray = [phoneBook sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(Person*)a name];
        NSString *second = [(Person*)b name];
        return [first compare:second];
    }];
    phoneBook = [sortedArray mutableCopy];
}
@end
