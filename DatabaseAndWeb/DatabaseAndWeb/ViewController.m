//
//  ViewController.m
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/23/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)textChange:(UITextField*)sender {
    _textView.text = sender.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
