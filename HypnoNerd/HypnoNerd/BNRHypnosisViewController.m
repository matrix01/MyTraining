//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Md. Milan Mia on 9/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "BNRHypnosisViewController.h"

@interface BNRHypnosisViewController ()

@end

@implementation BNRHypnosisViewController

- (IBAction)buttonAction:(UIButton *)sender {
    NSLog(@"Test");
}

-(void)loadView{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myView setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:myView];
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
