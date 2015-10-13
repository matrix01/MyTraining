//
//  ViewController.m
//  MapKitTest
//
//  Created by Md. Milan Mia on 10/12/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _let = 50;
    _lng = -100;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D cordinate;
    cordinate.latitude = _let;
    cordinate.longitude = _lng;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cordinate, 750, 750);
    [self.myMap setRegion:viewRegion animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
