//
//  BNRReminderViewController.h
//  HypnoNerd
//
//  Created by Md. Milan Mia on 9/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRReminderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addReminder:(id)sender;
@end
