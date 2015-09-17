//
//  ViewController.h
//  ChangeButtonNameUsingCode
//
//  Created by Md. Milan Mia on 9/1/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *inputList;
    int counter;
}

-(void) createComponents;
-(void) showList;
@property (strong, nonatomic) IBOutlet UITextField *takeName;
@property (strong, nonatomic) IBOutlet UIButton *nameChange;

@end

