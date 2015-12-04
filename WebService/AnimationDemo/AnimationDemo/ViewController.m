//
//  ViewController.m
//  AnimationDemo
//
//  Created by Md. Milan Mia on 10/13/15.
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
-(void)loadView{
    [super loadView];
    CGRect frame = [UIScreen mainScreen].bounds;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame = CGRectMake(_myTextField.frame.origin.x, _myTextField.frame.origin.y+300, _myTextField.frame.size.width, _myTextField.frame.size.height);
        self.myTextField.frame = frame;
    } completion:^(BOOL finished) {
        CGRect frame = CGRectMake(_myTextField.frame.origin.x, _myTextField.frame.origin.y+300, _myTextField.frame.size.width, _myTextField.frame.size.height); 
        self.myTextField.frame = frame;
    }
    ];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_myTextField resignFirstResponder];
    return YES;
}
-(void) textFieldAnimate {
    
}
-(void) labelAnimate{
    _myLabel.alpha = 1.0;
    //    [UIView animateWithDuration:1.0 animations:^{
    //        _myLabel.alpha = 1.0;
    //    }];
    //    [UIView animateWithDuration:4.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    //        _myLabel.alpha = 1.0;
    //    } completion:^(BOOL finished) {
    //    }];
    //    UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    //    CGRect newFrame = _myLabel.frame;
    //    newFrame.origin.x = newFrame.origin.x+20;
    [UIView animateKeyframesWithDuration:4 delay:0.3 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            _myLabel.center = self.view.center;
            _myLabel.backgroundColor = [UIColor cyanColor];
            NSLog(@"First:");
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            int x = arc4random() % (int)self.view.frame.size.width;
            int y = arc4random() % (int)self.view.frame.size.height;
            _myLabel.center = CGPointMake(x, y);
            _myLabel.backgroundColor = [UIColor redColor];
            NSLog(@"second x y: %d %d", x, y);
        }];
        //        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
