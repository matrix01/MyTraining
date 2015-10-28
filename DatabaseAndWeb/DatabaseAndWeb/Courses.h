//
//  Courses.h
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/23/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Courses : NSObject {
    NSString *_title;
    NSString *_url;
    NSString *_instructor;
}
-(void)setTitle:(NSString*)title WebUrl:(NSString*)url InstructorName:(NSString*)instructor;
@end
