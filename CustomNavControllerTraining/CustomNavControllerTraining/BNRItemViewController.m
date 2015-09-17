//
//  BNRItemViewController.m
//  CustomNavControllerTraining
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "BNRItemViewController.h"
#import "DetailViewController.h"
@interface BNRItemViewController (){
    DetailViewController *dvc;
}
@end

@implementation BNRItemViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    i=0;
    dvc = (DetailViewController*)[self.storyboard
                    instantiateViewControllerWithIdentifier:@"detailView"];
    self.navigationItem.title=@"Item View";
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

- (IBAction)firstButton:(UIButton *)sender {
    dvc.count = ++i;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (IBAction)secondButton:(UIButton *)sender {

}
@end
