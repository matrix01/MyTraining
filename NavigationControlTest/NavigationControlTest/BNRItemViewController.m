//
//  BNRItemViewController.m
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "BNRItemViewController.h"
@interface BNRItemViewController (){
    DetailViewController *dvc;
}

@end

@implementation BNRItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Item View";
    dvc = (DetailViewController*) [self.storyboard
        instantiateViewControllerWithIdentifier:@"detailView"];
    dvc.myDelegate= self;
}
-(void)printMyName:(NSString*) myName AndAge:(int)age{
    self.myLabel.text = @"Milan Mia";
    NSLog(@"My Name is %@ And Age: %d",myName, age);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.title=@"Back";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"Item View";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)firstButton:(UIButton *)sender {
    [self.navigationController pushViewController:dvc animated:YES];
}

- (IBAction)secondButton:(UIButton *)sender {
}
@end
