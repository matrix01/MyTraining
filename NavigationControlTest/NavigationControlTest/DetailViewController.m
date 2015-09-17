//
//  DetailViewController.m
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRNextViewController.h"
@interface DetailViewController (){
    BNRNextViewController *nvc;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor grayColor]];
    self.navigationItem.title =@"Detail View";

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushViewController)];
    nvc = (BNRNextViewController*)[self.storyboard
                                   instantiateViewControllerWithIdentifier:@"nextView"];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pushViewController{
    [self.navigationController pushViewController:nvc animated:YES];
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

@end
