//
//  Tab1TableViewController.m
//  SampleApp
//
//  Created by Saurabh on 08/04/16.
//  Copyright © 2016 Extentia Information Technology. All rights reserved.
//

#import "Tab1TableViewController.h"

@interface Tab1TableViewController () {

    __weak IBOutlet UITextField *dateTextField;
    __weak IBOutlet UIDatePicker *datePicker;

    __weak IBOutlet UIImageView *bulbImageview;
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
    if([tableview respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        tableview.cellLayoutMarginsFollowReadableWidth = NO;
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [datePicker setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSLog(@"***CALLED");
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }

}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}
//
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)displayDate {
    NSDate *date = [datePicker date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"**selected date %@", dateString);
    dateTextField.text = dateString;
}
- (IBAction)dateChanged:(id)sender {

    [self displayDate];

}

- (IBAction)switchStatusChanged:(id)sender {

    UISwitch *bulbSwitch = (UISwitch*)sender;

    if (bulbSwitch.on) {
        NSLog(@"***ON");
        [bulbImageview setImage:[UIImage imageNamed:@"OnBulb"]];
    }else {
        NSLog(@"***Off");
        [bulbImageview setImage:[UIImage imageNamed:@"OffBulb"]];
    }
}
- (IBAction)calenderButtonPressed:(id)sender {
    if ([datePicker isHidden]) {
        [datePicker setHidden:NO];
        [self displayDate];
    }
}
@end
