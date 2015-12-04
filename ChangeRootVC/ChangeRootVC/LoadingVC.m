//
//  LoadingVC.m
//  ChangeRootVC
//
//  Created by Md. Milan Mia on 9/29/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LoadingVC.h"
#import "UIImage+animatedGIF.h"
#import "LogPageVC.h"

@interface LoadingVC (){
    LogPageVC *lpc;
    NSTimer *timer;
}
@end

@implementation LoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"Loading";
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"477" withExtension:@"GIF"];
    self.loadingImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    lpc = (LogPageVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runScheduledTask) userInfo:nil repeats:NO];
}
-(void)runScheduledTask {
    [self.navigationController setViewControllers:[NSArray arrayWithObject:lpc] animated:YES];
    timer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
