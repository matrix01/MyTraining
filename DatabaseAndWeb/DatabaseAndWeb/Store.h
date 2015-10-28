//
//  Store.h
//  PhoneBook
//
//  Created by Md. Milan Mia on 9/22/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject{
    NSMutableArray *phoneBook;
}
@property (nonatomic, readonly) NSMutableArray *phoneBook;
+(instancetype)sharedStore;
-(NSMutableArray*)getItems;
-(void)deleteItem:(NSInteger)indexNo;
@end
