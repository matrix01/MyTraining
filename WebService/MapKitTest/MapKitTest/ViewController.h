//
//  ViewController.h
//  MapKitTest
//
//  Created by Md. Milan Mia on 10/12/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController
@property (nonatomic) float let;
@property (nonatomic) float lng;
@property (weak, nonatomic) IBOutlet MKMapView *myMap;

@end

