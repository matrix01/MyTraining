//
//  ViewController.h
//  WebViewAssignment
//
//  Created by Md. Milan Mia on 11/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource> {
    NSArray *pageUrl;
}
@property (strong, nonatomic) UIPageViewController *pageVC;
@end

