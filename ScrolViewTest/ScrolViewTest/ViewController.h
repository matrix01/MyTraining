//
//  ViewController.h
//  ScrolViewTest
//
//  Created by Md. Milan Mia on 10/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    int k;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

