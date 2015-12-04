//
//  GalleryVC.h
//  ScrolViewTest
//
//  Created by Md. Milan Mia on 10/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
