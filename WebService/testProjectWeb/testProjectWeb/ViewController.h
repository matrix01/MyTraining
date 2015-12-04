//
//  ViewController.h
//  testProjectWeb
//
//  Created by Md. Milan Mia on 10/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSArray *arry;
    __weak IBOutlet UITableView *myTable;
}


@end

