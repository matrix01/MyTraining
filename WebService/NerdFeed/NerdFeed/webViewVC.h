//
//  webViewVC.h
//  NerdFeed
//
//  Created by Md. Milan Mia on 10/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewVC : UIViewController
@property (nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;


@end
