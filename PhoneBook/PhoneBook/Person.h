//
//  Person.h
//  PhoneBook
//
//  Created by Md. Milan Mia on 9/22/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString *fullName;
    NSString *address;
    NSString *imageName;
}
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *imageName;
-(void)addPerson: (NSString*)pName personAddress: (NSString*)pAddress imageName: (NSString*) iName;
@end
