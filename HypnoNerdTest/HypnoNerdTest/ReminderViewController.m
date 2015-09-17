//
//  ReminderViewController.m
//  HypnoNerdTest
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor cyanColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addReminder:(UIButton *)sender {
    
    NSLog(@"Setting the reminder on %@", self.datePicker.date);
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me! Ha ha ha";
    note.fireDate = self.datePicker.date;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}
@end
