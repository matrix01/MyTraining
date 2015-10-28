//
//  Courses.m
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/23/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Courses.h"

@implementation Courses
-(void)setTitle:(NSString *)title WebUrl:(NSString *)url InstructorName:(NSString *)instructor {
    _title = title;
    _url = url;
    _instructor = instructor;
}
@end
