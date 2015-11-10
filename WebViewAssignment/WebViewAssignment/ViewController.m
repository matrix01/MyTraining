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
    NSLog(@"%@", pageContentViewController.urlString);
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    lastIndex = index;
    if (_nextButton.isEnabled==false) {
        [_nextButton setEnabled:YES];
    }
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
    lastIndex = index;
    if (_prevButton.isEnabled==false) {
        [_prevButton setEnabled:YES];
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [pageUrl count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}
- (IBAction)nextPage:(id)sender {
    PageViewController *startingViewController = [self viewControllerAtIndex:++lastIndex];
    NSArray *viewControllers = @[startingViewController];
    [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    if (_prevButton.isEnabled==false) {
        [_prevButton setEnabled:YES];
    }
    if(lastIndex+1 == [pageUrl count])
        [_nextButton setEnabled:NO];
}
- (IBAction)prevPage:(id)sender {
    PageViewController *startingViewController = [self viewControllerAtIndex:--lastIndex];
    NSArray *viewControllers = @[startingViewController];
    [_pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    if (_nextButton.isEnabled==false) {
        [_nextButton setEnabled:YES];
    }
    if(lastIndex == 0)
        [_prevButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
