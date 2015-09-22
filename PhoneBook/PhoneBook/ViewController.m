//
//  ViewController.m
//  PhoneBook
//
//  Created by Md. Milan Mia on 9/22/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Store.h"
#import "myCustomCell.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self action:@selector(addNewItem)];
    self.navigationItem.rightBarButtonItem = addButton;
    [[Store sharedStore] createItems];
}
-(void)addNewItem{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[Store sharedStore] getItems] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     myCustomCell *cell = [tableView
                            dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
        [tableView registerNib: [UINib nibWithNibName:@"myCustomCell" bundle: nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    NSArray *persons = [[Store sharedStore] getItems];
    Person *person = persons[indexPath.row];
    cell.name.text = person.fullName;
    cell.address.text= person.address;
    cell.imageName.text= person.imageName;
    return cell;
}
@end
