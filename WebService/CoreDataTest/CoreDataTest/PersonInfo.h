//
//  PersonInfo.h
//  
//
//  Created by Md. Milan Mia on 10/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonTable;

@interface PersonInfo : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * personName;
@property (nonatomic, retain) PersonTable *relationship;

@end
