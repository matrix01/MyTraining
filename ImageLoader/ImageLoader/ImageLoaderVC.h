//
//  ImageLoaderVC.h
//  ImageLoader
//
//  Created by Md. Milan Mia on 10/29/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLoaderVC : UITableViewController{
    NSArray *dataSource;
    NSMutableArray *imageSource;
    IBOutlet UITableView *myTable;
}

@end
