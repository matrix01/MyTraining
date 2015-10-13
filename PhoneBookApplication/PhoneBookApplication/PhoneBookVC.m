//
//  PhoneBookVC.m
//  PhoneBookApplication
//
//  Created by Md. Milan Mia on 10/6/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "PhoneBookVC.h"
#import "Store.h"
#import "ContactEditVC.h"
#import "Person.h"

@interface PhoneBookVC(){
    ContactEditVC *contactEdit;
}
@end
@implementation PhoneBookVC
- (void)viewDidLoad {
    [super viewDidLoad];
    contactEdit = (ContactEditVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"contactEdit"];
    pickerView.hidden = YES;
    flag = false;
    offset = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    [myTable reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Store sharedStore].phoneBook count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
    }
    UILabel *label = (UILabel*)[cell viewWithTag:130];
    Person *person = [[Store sharedStore].phoneBook objectAtIndex:indexPath.row];
    label.text = person.name;
    label = (UILabel*)[cell viewWithTag:131];
    label.text = [person.phoneNo objectAtIndex:0];
    label = (UILabel*)[cell viewWithTag:132];
    label.text = person.email;
    UIImageView *imageV = (UIImageView*)[cell viewWithTag:133];
    UIImage *image = person.image;
    if(image){
        imageV.image = image;
    }
    else{
        imageV.image = [UIImage imageNamed:@"contact"];
    }
    /*Cell configure End*/
    UIView *myView = (UIView*)[cell viewWithTag:151];
    if(indexPath.row%2){
        [myView setBackgroundColor:[UIColor grayColor]];
    }
    else{
        [myView setBackgroundColor:[UIColor brownColor]];
    }
    __block CGRect newFrame = myView.frame;
    newFrame.origin.x = offset;
    [UIView animateWithDuration:0.3 animations:^{
        myView.frame = newFrame;
    }];
    UIView *leftView = (UIView*)[cell viewWithTag:145];
    leftView.hidden = !flag;
    return cell;
}
#pragma mark - mail, message delegates
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)sendMessage:(id)sender {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        controller.body = @"SMS message here";
        controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}
- (IBAction)sendMail:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"example@email.com"]];
        [composeViewController setSubject:@"example subject"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}
#pragma mark - Edit mode actions
- (IBAction)toggleEditingMode:(id)sender {
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
- (IBAction)editContact:(UIButton *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:myTable];
    NSIndexPath *indexPath = [myTable indexPathForRowAtPoint:buttonPosition];
    contactEdit.index = indexPath;
    [self.navigationController pushViewController:contactEdit animated:YES];
}
- (IBAction)deleteContact:(UIButton *)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:myTable];
    NSIndexPath *indexPath = [myTable indexPathForRowAtPoint:buttonPosition];
    [[Store sharedStore].phoneBook removeObjectAtIndex:indexPath.row];
    [myTable reloadData];
}
#pragma mark - picker delegates
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[Store sharedStore].phoneBook count];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Person *person = [[Store sharedStore].phoneBook objectAtIndex:row];
    return person.name;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}
- (IBAction)showPicker:(id)sender {
    pickerView.hidden = NO;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
}
#pragma mark - picker actions
- (IBAction)pickerDone:(id)sender {
    NSInteger row= [myPickerView selectedRowInComponent:0];
    Person *person =[[Store sharedStore].phoneBook objectAtIndex:row];
    UIImage *imageAttach = person.image;
    pickerView.hidden = YES;
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"example@email.com"]];
        [composeViewController setSubject:@"example subject"];
        NSData *myData = UIImageJPEGRepresentation(imageAttach, 0.9);
        [composeViewController addAttachmentData:myData mimeType:@"image/jpg" fileName:@"attach.jpg"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}
- (IBAction)pickerCancel:(id)sender {
    pickerView.hidden = YES;
}
- (IBAction)rightNavButton:(id)sender {
    [self.navigationController pushViewController:contactEdit animated:YES];
}

@end