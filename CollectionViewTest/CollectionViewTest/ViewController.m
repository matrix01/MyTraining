//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Md. Milan Mia on 10/19/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    collectionImages = [NSArray arrayWithObjects:@"image1.png",@"image2.png", @"image3.png", @"image4.png", @"image5.png",@"image6.png",@"image7.png", @"image8.png", @"image9.png", @"image10.png" , nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [collectionImages count];
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:100];
    imageView.image =[UIImage imageNamed: collectionImages[indexPath.row]];
    return cell;
}
@end
