//
//  ViewController.h
//  GPSDemo
//
//  Created by Md. Milan Mia on 10/12/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@property (weak, nonatomic) IBOutlet UILabel *let;
@property (weak, nonatomic) IBOutlet UILabel *lng;
@property (weak, nonatomic) IBOutlet UILabel *address;



@end

