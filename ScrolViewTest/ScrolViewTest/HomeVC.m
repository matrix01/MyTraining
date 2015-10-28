//
//  HomeVC.m
//  ScrolViewTest
//
//  Created by Md. Milan Mia on 10/15/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "HomeVC.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "GalleryVC.h"

@interface HomeVC () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITabBarDelegate> {
    GalleryVC *galleryVc;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
@property(nonatomic, weak) IBOutlet UITextField *textField;
@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;
- (IBAction)shareButtonTapped:(id)sender;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResults = [[NSMutableDictionary alloc]init];
    self.searches = [[NSMutableArray alloc]init];
    self.flickr = [[Flickr alloc] init];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    galleryVc = (GalleryVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"galleryView"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)shareButtonTapped:(id)sender {
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
                [self.collectionView reloadData];
            });
        } else {
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
    [textField resignFirstResponder];
    return YES; 
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
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    FlickrPhoto *pto = self.searchResults[searchTerm][indexPath.row];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:100];
    imageView.image = pto.thumbnail;
    NSLog(@"%lld", pto.photoID);
    UILabel *label = (UILabel*)[cell viewWithTag:120];
    label.text = [NSString stringWithFormat:@"Sec:%ld Row:%ld",indexPath.section, indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}
#pragma mark – UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *searchTerm = self.searches[indexPath.section];
//    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
    return CGSizeMake(self.collectionView.frame.size.width /3, 150);
}
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 30.0;
//}
- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                         UICollectionElementKindSectionHeader withReuseIdentifier:@"myCustomHeader" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    UILabel *label = (UILabel*)[headerView viewWithTag:110];
    label.text = searchTerm;
    return headerView;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 10)
        [self.navigationController pushViewController:galleryVc animated:YES];
}
@end
