//
//  PageViewController.m
//  WebViewAssignment
//
//  Created by Md. Milan Mia on 11/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController () {
    NSString* ret;
    bool downScroll;
}
@end

@implementation PageViewController

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString* str = request.URL.relativeString;
    str = [str lastPathComponent];
    NSArray* array = [str componentsSeparatedByString:@"%20"];
    NSError *error = nil;
    NSData *data = nil;
    downScroll = NO;
    if([NSJSONSerialization isValidJSONObject:array]){
        data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
        ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    int row = 9, col=3;
    NSString *s=[[NSString alloc] initWithFormat:@"printTable(%i, %i, '%@');",row, col,  ret];
    [_webView stringByEvaluatingJavaScriptFromString:s];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString* s=[[NSString alloc] initWithFormat:@"hello_out();"];
    [webView stringByEvaluatingJavaScriptFromString:s];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView.scrollView setDelegate:self];
    /* Load The HTML file with table*/
    NSBundle *thisBundle = [NSBundle mainBundle];
    NSString *path = [thisBundle pathForResource:_urlString ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:path];
    [_webView loadRequest:[NSURLRequest requestWithURL:instructionsURL]];
    /*Load HTML End*/
}
- (IBAction)reloadButton:(id)sender {
    NSString *s=[[NSString alloc] initWithFormat:@"printTable('%@');",  ret];
    [_webView stringByEvaluatingJavaScriptFromString:s];  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint velocity = [[scrollView panGestureRecognizer]velocityInView:scrollView.superview];
    if (velocity.y == 0) {
        return;
    }
    if (velocity.y < -1) {
        downScroll = YES;
    }
    else if (velocity.y > 1) {
        downScroll = NO;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(downScroll){
        NSString *s=[[NSString alloc] initWithFormat:@"showMore();"];
        [_webView stringByEvaluatingJavaScriptFromString:s];
    }
    downScroll = NO;
}
@end
