//
//  ViewController.h
//  CollectionViewTest
//
//  Created by Md. Milan Mia on 10/19/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSArray *collectionImages;
}

@end

