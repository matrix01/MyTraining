//
//  ReminderViewController.h
//  HypnoNerdTest
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *addReminderButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)addReminder:(UIButton *)sender;
@end
