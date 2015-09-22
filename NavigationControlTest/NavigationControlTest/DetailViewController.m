//
//  DetailViewController.m
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize myDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor cyanColor]];
    self.navigationItem.title =@"Detail View";
    
    /*Text field*/
    textFieldTest = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [textFieldTest setBackgroundColor:[UIColor redColor]];
    textFieldTest.delegate=self;
    [self.view addSubview:textFieldTest];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backIndicatorImage=[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage=[UIImage imageNamed:@"back"];
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

- (IBAction)printName:(UIButton *)sender {
    [self.myDelegate printMyName:@"Milan Mia" AndAge:24];
    [self.myDelegate printFriendsName];
}
@end
