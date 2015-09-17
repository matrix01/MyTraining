//
//  DetailViewController.m
//  CustomNavControllerTraining
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize count;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Detail View";
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    NSLog(@"Detail View Called");
}
-(void)viewWillAppear:(BOOL)animated{
    self.pushCounter.text = [NSString stringWithFormat:@"%d", count];
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

@end
