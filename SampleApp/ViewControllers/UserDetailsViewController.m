//
//  UserDetailsViewController.m
//  SampleApp
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()
- (IBAction)goBackToMainScreen:(UIButton *)sender;
@end

@implementation UserDetailsViewController

#pragma mark - View Lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - IBAction methods.
- (IBAction)goBackToMainScreen:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
