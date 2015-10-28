//
//  GalleryVC.m
//  ScrolViewTest
//
//  Created by Md. Milan Mia on 10/21/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "GalleryVC.h"
#import "Flickr.h"
#import "FlickrPhoto.h"

@interface GalleryVC () {
    NSString *searchSec;
}

@property(nonatomic, weak) IBOutlet UITextField *textField;
@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;

@end

@implementation GalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResults = [[NSMutableDictionary alloc]init];
    self.searches = [[NSMutableArray alloc]init];
    self.flickr = [[Flickr alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITextFieldDelegate methods
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            if(![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %lu photos matching %@", (unsigned long)[results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results; }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_myTable reloadData];
            });
        } else {
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - tableView Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searches count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTableCell" forIndexPath:indexPath];
    UICollectionView *collectionView = (UICollectionView*)[cell viewWithTag:302];
    NSLog(@"%f", collectionView.frame.origin.y);
    if(indexPath.row%2){
    [collectionView setBackgroundColor:[UIColor redColor]];
    }
    else
        [collectionView setBackgroundColor:[UIColor greenColor]];
        UILabel *label = (UILabel*)[cell viewWithTag:300];
    label.text = searchSec;
    searchSec = self.searches[0];
    NSLog(@"%@ %ld", searchSec, indexPath.row);
    return cell;
}
#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.searches count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];
    FlickrPhoto *pto = self.searchResults[searchSec][indexPath.row];
    NSLog(@"%lld", pto.photoID);
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:301];
    imageView.image = pto.thumbnail;
//    NSLog(@"%lld", pto.photoID);
    return cell;
}
@end
