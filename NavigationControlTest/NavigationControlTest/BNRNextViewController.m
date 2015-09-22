//
//  BNRNextViewController.m
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "BNRNextViewController.h"

@interface BNRNextViewController (){
    DetailViewController *dvc;
}

@end

@implementation BNRNextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor brownColor]];
    dvc= (DetailViewController*)[self.storyboard
                                  instantiateViewControllerWithIdentifier:@"detailView"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushViewController)];
    self.navigationItem.rightBarButtonItem = rightButton;
    dvc.myDelegate =self;
}
-(void)pushViewController{
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)printMyName:(NSString *)myName AndAge:(int)age{
    NSLog(@"Print from Next View controller %@ %d", myName, age);
}
-(void)printFriendsName{
    NSLog(@"Test");
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
