//
//  myCustomCell.h
//  CustomCellTableViewUsingXib
//
//  Created by Md. Milan Mia on 9/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstItem;
@property (weak, nonatomic) IBOutlet UILabel *middleItem;
@property (weak, nonatomic) IBOutlet UILabel *lastItem;

@end
