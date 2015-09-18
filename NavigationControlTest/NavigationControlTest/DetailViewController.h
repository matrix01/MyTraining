//
//  DetailViewController.h
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomProtocolTest <NSObject>
@required
-(void) printMyName:(NSString*) myName AndAge:(int)age;
@optional
-(void) printFriendsName;
@end

@interface DetailViewController : UIViewController<UITextFieldDelegate>{
    UITextField *textFieldTest;
}
- (IBAction)printName:(UIButton *)sender;
@property(nonatomic, weak)id <CustomProtocolTest> myDelegate;
@end
