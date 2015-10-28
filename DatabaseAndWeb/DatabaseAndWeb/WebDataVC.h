//
//  WebDataVC.h
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/23/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebDataVC : UITableViewController <UIActionSheetDelegate> {
    NSMutableArray *jsonArray;
    IBOutlet UITableView *myTable;
}
- (void)fetchData;
@end
