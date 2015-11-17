//
//  VideoPlayVC.h
//  AVFoundationCheck
//
//  Created by Md. Milan Mia on 11/17/15.
//  Copyright © 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;
@end
