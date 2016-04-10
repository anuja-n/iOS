//
//  Tab2ViewController.m
//  SampleApp
//

#import "Tab2ViewController.h"

@interface Tab2ViewController ()
@property CLLocation *location;
@end

@implementation Tab2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.location = [[CLLocation alloc]init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100.0; // Will notify the LocationManager every 100 meters
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:YES];

    // Request authorization to access location
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    // If authorized successfully, start updating location
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;

    }
}

/*!
 @method     setLocationOnMap
 @abstract   This method is called to set location on map.
 @discussion This method takes lattitude and longitude of current location and 
             uses reverse geocoding to show address in annotation
 @params     (CLLocation*)updatedLocation
 */

- (void)setLocationOnMap:(CLLocation*)updatedLocation {

    // Set span
    float spanX = 0.00550;
    float spanY = 0.00550;

    // Set lattitude and longitude of updated location to region
    MKCoordinateRegion region;
    region.center.latitude = self.location.coordinate.latitude;
    region.center.longitude = self.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(spanX, spanY);
    [self.mapView setRegion:region animated:YES];
    NSLog(@"%@", self.location.description);

    // Use reverse geocoding to convert lattitude and logitude into address
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finding address");
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {

            // Add annotation on map
            CLPlacemark *placemark = [placemarks lastObject];
            MKPlacemark *annotationPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
            [self.mapView addAnnotation:annotationPlacemark];
        }
    }];

}

/*!
 @method     locationManager:didUpdateLocations:
 @abstract   This method is called when location is changed.
 @discussion This method sets new updated location on map.
 @params     (CLLocationManager *)manager, (NSArray *)locations
 */

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //
    self.location = [locations lastObject];
    [self setLocationOnMap:self.location];
//

    // here we get the current location
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
