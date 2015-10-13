//
//  ViewController.h
//  WebAnotherTest
//
//  Created by Md. Milan Mia on 10/8/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController{
    NSArray *jsonArray;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;

-(void)fetchFeed;
@end

