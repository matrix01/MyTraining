//
//  ViewController.m
//  CustomCellTableViewUsingXib
//
//  Created by Md. Milan Mia on 9/10/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#include "myCustomCell.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize items, myTable, myDict, firstName, midName, lastName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    myDict = [[NSMutableDictionary alloc]init];
    key = @0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [myDict count];
}
-(UITableViewCell *)tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
        [tableView registerNib: [UINib nibWithNibName:@"myCustomCell" bundle: nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    return cell;
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(myCustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber* _key = [NSNumber numberWithInteger:indexPath.row];
    NSArray *tmp = myDict[_key];
    cell.firstItem.text = [tmp objectAtIndex:0];
    cell.middleItem.text = [tmp objectAtIndex:1];
    cell.lastItem.text = [tmp objectAtIndex:2];
}
- (IBAction)addName:(UIButton *)sender {
    items =@[self.firstName.text, self.midName.text, self.lastName.text];
    myDict[key] = items;
    key = @(key.intValue + 1);
    [firstName resignFirstResponder];
    [midName resignFirstResponder];
    [lastName resignFirstResponder];
    [myTable reloadData];
}
// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
