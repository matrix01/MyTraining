//
//  NerdFeedVC.m
//  
//
//  Created by Md. Milan Mia on 10/8/15.
//
//

#import "NerdFeedVC.h"
#import "webViewVC.h"

@interface NerdFeedVC (){
    webViewVC *wvc;
}
@property (nonatomic) NSURLSession *session;
@end

@implementation NerdFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    wvc = (webViewVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self fetchFeed];
    });
}
-(void)fetchFeed {
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"json %@", json);
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"json Object Dictionary: %@", jsonObject);
//        jsonArray = [jsonObject objectForKey:@"courses"];
//        NSLog(@"Courses Array: %@", [jsonArray objectAtIndex:2][@"title"]);
//        NSLog(@"%lu", (unsigned long)[jsonArray count]);
        //[_myTable reloadData];
        
        jsonArray = [[NSArray alloc] initWithArray:[jsonObject objectForKey:@"courses"]];
        //jsonArray = [jsonObject objectForKey:@"courses"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.myTable reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count: %lu", (unsigned long)[jsonArray count]);
    return [jsonArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text =[jsonArray objectAtIndex:indexPath.row][@"url"];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    wvc.url =[jsonArray objectAtIndex:indexPath.row][@"url"];
    [self.navigationController pushViewController:wvc animated:YES];
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
