//
//  ViewController.h
//  CustomViewAnimation
//
//  Created by Md. Milan Mia on 10/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *myView;
- (IBAction)animateView:(UIButton *)sender;

@end

