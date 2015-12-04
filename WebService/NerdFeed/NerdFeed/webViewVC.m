//
//  webViewVC.m
//  NerdFeed
//
//  Created by Md. Milan Mia on 10/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "webViewVC.h"

@interface webViewVC ()

@end

@implementation webViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *link = [NSURL URLWithString:_url];
    NSURLRequest *req = [NSURLRequest requestWithURL:link];
    [_myWebView loadRequest:req];
    self.title = @"WebPage";
    // Do any additional setup after loading the view.
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
