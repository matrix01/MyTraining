//
//  ViewController.m
//  GPSDemo
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
    locationManager = [[CLLocationManager alloc]init];
    placemark = [[CLPlacemark alloc]init];
    geocoder = [[CLGeocoder alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)getLocation:(UIButton *)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLoc = [locations objectAtIndex:0];
    NSLog(@"%@", currentLoc);
    _let.text = [NSString stringWithFormat:@"%f",currentLoc.coordinate.latitude];
}
@end
