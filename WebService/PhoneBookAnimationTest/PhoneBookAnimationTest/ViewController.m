//
//  ViewController.m
//  PhoneBookAnimationTest
//
//  Created by Md. Milan Mia on 10/14/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = NO;
    offset = 0;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView data source and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
        [tableView registerNib: [UINib nibWithNibName:@"CustomCell" bundle: nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    __block CGRect newFrame = cell.topView.frame;
    newFrame.origin.x = offset;
    [UIView animateWithDuration:0.3 animations:^{
        cell.topView.frame = newFrame;
    }];

//    cell.label.text = @"TTTT";
    return cell;
}
- (IBAction)toggleEditMode:(id)sender {
    if(flag){
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blueColor];
        flag = false;
        offset = 0;
    }
    else{
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
        flag = true;
        offset = 45;
    }
    [myTable reloadData];
}
@end
