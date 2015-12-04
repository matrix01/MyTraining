//
//  ViewController.m
//  ScrolViewTest
//
//  Created by Md. Milan Mia on 10/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "HomeVC.h"

@interface ViewController (){
    HomeVC *homeVc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    homeVc = (HomeVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
}
- (IBAction)languageChange:(id)sender {
    UIButton *button = (UIButton*)sender;
    if(button.tag == 10)
        homeVc.language = @"En";
    else homeVc.language = @"Bn";
    [self.navigationController pushViewController:homeVc animated:YES];
}
@end
