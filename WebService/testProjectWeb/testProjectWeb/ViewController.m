//
//  ViewController.m
//  testProjectWeb
//
//  Created by Md. Milan Mia on 10/9/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSURLSession *session;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arry = [[NSArray alloc]init];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
        dispatch_async(dispatch_get_main_queue(), ^{
           [self fetchFeed];
        });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arry count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.textLabel.text = @"";
    return cell;
}
-(void)fetchFeed {
        NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
        NSURL *url = [NSURL URLWithString:requestString];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask = [self->session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
            //NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //        NSLog(@"json %@", json);
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //        NSLog(@"json Object Dictionary: %@", jsonObject);
            arry = [jsonObject objectForKey:@"courses"];
    //        NSLog(@"Courses Array: %@", [jsonArray objectAtIndex:2][@"title"]);
    //        NSLog(@"%lu", (unsigned long)[jsonArray count]);
    //[_myTable reloadData];
    
    //        jsonArray = [[NSArray alloc] initWithArray:[jsonObject objectForKey:@"courses"]];
    //        //jsonArray = [jsonObject objectForKey:@"courses"];
            dispatch_async(dispatch_get_main_queue(), ^{
    
                [myTable reloadData];
                if ([[NSThread currentThread] isMainThread]){
                    NSLog(@"In main thread--completion handler");
                }
                else{
                    NSLog(@"Not in main thread--completion handler");
                }
            });
        }];
        [dataTask resume];
}
@end
