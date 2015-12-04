//
//  ViewController.m
//  TurnJs
//
//  Created by Md. Milan Mia on 12/3/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *_webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *thisBundle = [NSBundle mainBundle];
    NSString *path = [thisBundle pathForResource:@"index" ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:path];
    NSLog(@"%@", instructionsURL);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:instructionsURL];
    [self._webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
