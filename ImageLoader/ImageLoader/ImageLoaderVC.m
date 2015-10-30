//
//  ImageLoaderVC.m
//  ImageLoader
//
//  Created by Md. Milan Mia on 10/29/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ImageLoaderVC.h"

@interface ImageLoaderVC (){
    NSOperationQueue *loaderQ;
}

@end

@implementation ImageLoaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@{@"name": @"Rezwan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Symon", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Muftee", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Milan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Rezwan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Symon", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Muftee", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Milan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Rezwan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Symon", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Muftee", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Milan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Rezwan", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Symon", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Muftee", @"url": @"http://lorempixel.com/200/200/"},
                   @{@"name": @"Milan", @"url": @"http://lorempixel.com/200/200/"}
                   ];
    imageSource = [@[] mutableCopy];
    loaderQ = [NSOperationQueue new];
    [self loadImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row][@"name"];
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    cell.imageView.layer.borderWidth = 2.0f;
    cell.imageView.layer.cornerRadius = 8.0f;
    cell.imageView.clipsToBounds = YES;
    
    if([imageSource count] >indexPath.row){
        cell.imageView.image = [UIImage imageWithData:[imageSource objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void) loadImage {
    for (NSDictionary *object in dataSource) {
        NSURL *url = [NSURL URLWithString:object[@"url"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            if(imageData){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imageSource addObject:imageData];
                    [myTable reloadData];
                });
            }
        });
//        __block NSData *imageData = nil;
//        NSBlockOperation *operationBlock = [NSBlockOperation blockOperationWithBlock:^{
//            imageData = [NSData dataWithContentsOfURL:url];
//        }];
//        operationBlock.completionBlock = ^(void){
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [imageSource addObject:imageData];
//                [myTable reloadData];
//            }];
//        };
//        [loaderQ addOperation:operationBlock];
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 

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
