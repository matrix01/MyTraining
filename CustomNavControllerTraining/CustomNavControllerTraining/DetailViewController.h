//
//  DetailViewController.h
//  CustomNavControllerTraining
//
//  Created by Md. Milan Mia on 9/16/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *pushCounter;
@property (nonatomic, assign) int count;
@end
