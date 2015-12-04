//
//  PersonTable.h
//  
//
//  Created by Md. Milan Mia on 10/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonInfo;

@interface PersonTable : NSManagedObject

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * roll;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) PersonInfo *relationship;

@end
