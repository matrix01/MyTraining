//
//  WebDataVC.m
//  DatabaseAndWeb
//
//  Created by Md. Milan Mia on 10/23/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "WebDataVC.h"
#import "Course.h"

@interface WebDataVC ()

@property (nonatomic) NSURLSession *session;

@end

@implementation WebDataVC
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dispatch_async(dispatch_get_main_queue(), ^{
       [self fetchData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fetchData {
    NSString *requestString = @"http://bookapi.bignerdranch.com/";//courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        //NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"json %@", json);
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        jsonArray = [[jsonObject objectForKey:@"courses"] mutableCopy];
        //jsonArray = [jsonObject objectForKey:@"courses"];
        //NSLog(@"Jason Array: %@", [jsonArray objectAtIndex:1]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [myTable reloadData];
        });
    }];
    [dataTask resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [jsonArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    NSDictionary *temp = [jsonArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [temp valueForKey:@"url"];
    cell.textLabel.text = [temp valueForKey:@"title"];
    return cell;
}

#pragma mark - Save and Retrieve Data from Database
#pragma mark - ActionSheet methods and delegate
- (IBAction)showActionSheet:(id)sender {
    NSString *actionSheetTitle = @"Database Action"; //Action Sheet Title
    NSString *other1 = @"Save Data";
    NSString *other2 = @"Load Data";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Destructive Button"]) {
    }
    if ([buttonTitle isEqualToString:@"Save Data"]) {
        for (NSDictionary *object in jsonArray) {
            NSManagedObjectContext *context = [self managedObjectContext];
            
            Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:context];
            course.title = object[@"title"];
            course.url = object[@"url"];
            course.instructor = object[@"instructor"];
            
            NSError *error = nil;
            if(![context save:&error]){
                NSLog(@"%@",error);
            }
        }
    }
    if ([buttonTitle isEqualToString:@"Load Data"]) {
//        NSDictionary *temp = [result objectAtIndex:0];
//        NSLog(@"%@", [temp valueForKey:@"title"]);
//        NSLog(@"%@",jsonArray);
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
