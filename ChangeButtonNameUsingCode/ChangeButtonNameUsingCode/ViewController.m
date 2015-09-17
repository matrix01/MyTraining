//
//  ViewController.m
//  ChangeButtonNameUsingCode
//
//  Created by Md. Milan Mia on 9/1/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    counter =0;
    [self createComponents];
}
-(void) createComponents{
    
    self.takeName = [[UITextField alloc]initWithFrame: CGRectMake(50, 150, 200, 30)];
    [self.takeName setText:@"No Text"];
    [self.takeName setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.takeName];
    
    self.nameChange = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.nameChange addTarget:self
               action:@selector(changeButtonName:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.nameChange setTitle:@"ADD" forState:UIControlStateNormal];
    self.nameChange.frame = CGRectMake(50.0, 210.0, 160.0, 40.0);
    [self.view addSubview:self.nameChange];
    [self.nameChange setBackgroundColor: [UIColor cyanColor]];
}
-(void) showList{
    
}
-(IBAction)changeButtonName:(id)sender{
    [self.nameChange setTitle:self.takeName.text forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
