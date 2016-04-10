//
//  Tab1TableViewController.m
//  SampleApp

#import "Tab1TableViewController.h"

@interface Tab1TableViewController () {

// TextField to display date selected by user
    __weak IBOutlet UITextField *dateTextField;

// Datepicker to select the date
    __weak IBOutlet UIDatePicker *datePicker;

// Imageview to show ON-OFF bulb images.
    __weak IBOutlet UIImageView *bulbImageview;

// DateFormatter to set date format
    NSDateFormatter *dateFormatter;

    IBOutlet UITableView *tableview;
}

- (IBAction)dateChanged:(id)sender;
- (IBAction)switchStatusChanged:(id)sender;
- (IBAction)calenderButtonPressed:(id)sender;

@end

@implementation Tab1TableViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEE, MMM dd yyyy hh:mm a"];
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];

    // hide datePicker when view is loaded
    [datePicker setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Class Mehods

/*!
 @method     displayDate
 @abstract   This method displays the date selected by user.
 @params     nil
 */
- (void)displayDate {
    NSDate *date = [datePicker date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"**selected date %@", dateString);
    dateTextField.text = dateString;
}

#pragma mark - IBAction methods

/*!
 @method     dateChanged
 @abstract   This method is called when date is changed from datepicker.
 @discussion This method displays date selected by user in textfield
 @params     sender
 */
- (IBAction)dateChanged:(id)sender {

    [self displayDate];

}

/*!
 @method     switchStatusChanged
 @abstract   This method is called when date is changed from datepicker.
 @discussion This method changes bulb image depending on switch status
 @params     sender
 */
- (IBAction)switchStatusChanged:(id)sender {

    UISwitch *bulbSwitch = (UISwitch*)sender;

    if (bulbSwitch.on) {
        [bulbImageview setImage:[UIImage imageNamed:@"OnBulb"]];
    }else {
        [bulbImageview setImage:[UIImage imageNamed:@"OffBulb"]];
    }
}

/*!
 @method     calenderButtonPressed
 @abstract   This method is called when calender button is pressed.
 @discussion This method displays datpicker if it is hidden and hides datepicker
             if it is displayed On tap of calender icon
 @params     sender
 */
- (IBAction)calenderButtonPressed:(id)sender {
    
    if ([datePicker isHidden]) {
        [datePicker setHidden:NO];
        [self displayDate];
    }
    else {
        [datePicker setHidden:YES];
    }
}
@end
