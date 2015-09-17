//
//  ViewController.h
//  CustomCellTableViewUsingXib
//
//  Created by Md. Milan Mia on 9/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    NSNumber *key;
}
@property(strong,nonatomic) NSArray *items;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property(strong, nonatomic) NSMutableDictionary *myDict;
@property (weak, nonatomic) IBOutlet UIButton *addNewName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *midName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;

@end

