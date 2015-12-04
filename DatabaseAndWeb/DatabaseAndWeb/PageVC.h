//
//  PageVC.h
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/28/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageWithImageVCViewController.h"

@interface PageVC : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
