//
//  DatabaseRWVC.h
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/26/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatabaseRWVC : UITableViewController{
    NSMutableArray *jsonArray;
    IBOutlet UITableView *dbTable;
}

@end
