//
//  Course.h
//  
//
//  Created by Md. Milan Mia on 10/23/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * instructor;

@end
