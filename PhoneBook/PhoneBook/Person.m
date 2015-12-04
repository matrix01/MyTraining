//
//  Person.m
//  PhoneBook
//
//  Created by Md. Milan Mia on 9/22/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize fullName, imageName, address;
-(void)addPerson: (NSString*)pName personAddress: (NSString*)pAddress imageName: (NSString*) iName {
    fullName = pName;
    address = pAddress;
    imageName = iName;
}
@end
