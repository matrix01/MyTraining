//
//  PageViewController.m
//  WebViewAssignment
//
//  Created by Md. Milan Mia on 11/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(self.navigationController.navigationBar.translucent == YES)
    {
        
        _webView.scrollView.contentOffset = CGPointMake(_webView.frame.origin.x, _webView.frame.origin.y - 54);
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

@end
