//
//  Tab2ViewController.m
//  SampleApp
//
//  Created by Saurabh on 08/04/16.
//  Copyright © 2016 Extentia Information Technology. All rights reserved.
//

#import "Tab2ViewController.h"

@interface Tab2ViewController ()
@property CLLocation *location;
@end

@implementation Tab2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.location = [[CLLocation alloc]init];
//    self.location = [[CLLocation alloc]initWithLatitude:19.017614 longitude:71.85616];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100.0; // Will notify the LocationManager every 100 meters
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
}
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:YES];
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;

    }
}
- (void)setLocationOnMap:(CLLocation*)updatedLocation {

    float spanX = 0.00550;
    float spanY = 0.00550;
    MKCoordinateRegion region;
    region.center.latitude = self.location.coordinate.latitude;
    region.center.longitude = self.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(spanX, spanY);
    [self.mapView setRegion:region animated:YES];
    NSLog(@"%@", self.location.description);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finding address");
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            MKPlacemark *annotationPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
            [self.mapView addAnnotation:annotationPlacemark];
        }
    }];

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = [locations lastObject];
    [self setLocationOnMap:self.location];
//

    // here we get the current location
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
