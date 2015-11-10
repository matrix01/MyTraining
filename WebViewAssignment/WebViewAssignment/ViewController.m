//
//  ViewController.m
//  WebViewAssignment
//
//  Created by Md. Milan Mia on 11/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "PageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lastIndex =0;
    pageUrl = @[@"http://www.google.com", @"http://www.bjitgroup.com", @"http://www.apple.com"];
    
    _pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    _pageVC.dataSource = self;
    
    PageViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    _pageVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    [_pageVC didMoveToParentViewController:self];
}
#pragma mark - PageViewControllerDataSource
- (PageViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([pageUrl count] == 0) || (index >= [pageUrl count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageContentVC"];
    pageContentViewController.urlString = pageUrl[index];
    pageContentViewController.pageIndex = index;
    lastIndex = index;
    NSLog(@"Set: %ld", (long)lastIndex);
    return pageContentViewController;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
//    lastIndex = index;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageViewController*) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [pageUrl count]) {
        return nil;
    }
  //  lastIndex = index;
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [pageUrl count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}
- (void)changePage:(UIPageViewControllerNavigationDirection)direction {
    NSUInteger pageIndex = ((PageViewController *) [_pageVC.viewControllers objectAtIndex:0]).pageIndex;
    
    if (direction == UIPageViewControllerNavigationDirectionForward) {
        pageIndex++;
    }
    else {
        pageIndex--;
    }
    
    PageViewController *viewController = [self viewControllerAtIndex:pageIndex];
    
    if (viewController == nil) {
        return;
    }
    
    [_pageVC setViewControllers:@[viewController]
                                  direction:direction
                                   animated:YES
                                 completion:nil];
}
- (IBAction)nextPage:(id)sender {
    [self changePage:UIPageViewControllerNavigationDirectionForward];    
//    NSLog(@"%ld", (long)lastIndex);
//    if(lastIndex+1<[pageUrl count]){
//        PageViewController *startingViewController = [self viewControllerAtIndex:++lastIndex];
//        NSArray *viewControllers = @[startingViewController];
//        [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    }
}
- (IBAction)prevPage:(id)sender {
    [self changePage:UIPageViewControllerNavigationDirectionReverse];
//    if(lastIndex>0){
//        PageViewController *startingViewController = [self viewControllerAtIndex:--lastIndex];
//        NSArray *viewControllers = @[startingViewController];
//        [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
