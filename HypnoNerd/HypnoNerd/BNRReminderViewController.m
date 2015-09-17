//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Md. Milan Mia on 9/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@end

@implementation BNRReminderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    self.tabBarItem.title = @"Hypnosis";
    self.tabBarItem.image =[[UIImage imageNamed:@"small"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //self.tabBarItem.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0);
        
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
- (IBAction)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}
@end
