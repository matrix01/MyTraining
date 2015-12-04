//
//  ViewController.h
//  PhoneBookAnimationTest
//
//  Created by Md. Milan Mia on 10/14/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *array;
    BOOL flag;
    int offset;
    __weak IBOutlet UITableView *myTable;
}

@end

