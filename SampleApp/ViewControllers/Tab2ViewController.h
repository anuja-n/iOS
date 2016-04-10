//
//  Tab2ViewController.h
//  SampleApp
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Tab2ViewController : UIViewController <CLLocationManagerDelegate>

// mapview to display current location of user.
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@end
