//
//  BNRItemViewController.h
//  NavigationControlTest
//
//  Created by Md. Milan Mia on 9/17/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@interface BNRItemViewController : UIViewController<CustomProtocolTest>
- (IBAction)firstButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
- (IBAction)secondButton:(UIButton *)sender;
@end
