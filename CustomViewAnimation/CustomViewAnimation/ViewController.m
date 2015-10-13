//
//  ViewController.m
//  CustomViewAnimation
//
//  Created by Md. Milan Mia on 10/5/15.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animateView:(UIButton *)sender {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    __block CGRect newFrame = _myView.frame;
    newFrame.origin.x+= (screenWidth - 100);
    
    [UIView animateWithDuration:1.0 animations:^{
        _myView.frame = newFrame;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0 animations:^{
            newFrame.origin.y+=(screenHeight-120);
            _myView.frame = newFrame;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0 animations:^{
                newFrame.origin.x-=(screenWidth-100);
                _myView.frame = newFrame;
            } completion:^(BOOL finished){
                [UIView animateWithDuration:1.0 animations:^{
                    newFrame.origin.y-=(screenHeight- 120);
                    _myView.frame = newFrame;
                }];
            }];
        }];
    }];
}
@end
