//
//  PageViewController.h
//  WebViewAssignment
//
//  Created by Md. Milan Mia on 11/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *urlString;
@property NSInteger pageIndex;

@end
