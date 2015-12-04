//
//  PageWithImageVCViewController.h
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/28/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageWithImageVCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end
