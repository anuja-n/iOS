//
//  Tab3ViewController.m
//  SampleApp
//
//  Created by Saurabh on 09/04/16.
//  Copyright © 2016 Extentia Information Technology. All rights reserved.
//

#import "Tab3ViewController.h"

@interface Tab3ViewController () <UITextViewDelegate> {

    __weak IBOutlet UITextView *textview;
    __weak IBOutlet UIPageControl *pageControl;
    __weak IBOutlet UIScrollView *imageScrollView;
    NSArray *imageArray;
}
- (IBAction)pageChanged:(id)sender;

@end

@implementation Tab3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = [[NSArray alloc]initWithObjects:@"image1",@"image2",@"image3", nil];
    [imageScrollView setBackgroundColor:[UIColor blackColor]];
    [imageScrollView setCanCancelContentTouches:NO];

//    imageScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    imageScrollView.clipsToBounds = NO;
    imageScrollView.scrollEnabled = YES;
    imageScrollView.pagingEnabled = YES;
    [textview setDataDetectorTypes:UIDataDetectorTypeAll];
//    [textview setDataDetectorTypes:UIDataDetectorTypePhoneNumber];

    [self addImagesToScrollview];
    [self addDoneToolBarToKeyboard:textview];
    // Do any additional setup after loading the view.
}

- (void)addImagesToScrollview {

    NSUInteger count;
    CGFloat xOrigin = 0;
    for (count=0;count <3; count++) {
//        NSString *imageName = [NSString stringWithFormat:@"image%lu.jpg", (nimages + 1)];
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:count]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

        CGRect rect = imageView.frame;
        rect.size.height = 130;
        rect.size.width = 320;
        rect.origin.x = xOrigin;
        rect.origin.y = 0;

        imageView.frame = rect;

        [imageScrollView addSubview:imageView];
        xOrigin += imageView.frame.size.width;

    }
    pageControl.numberOfPages = [imageArray count];

    [imageScrollView setContentSize:CGSizeMake(xOrigin, [imageScrollView bounds].size.height)];


}
-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.barStyle = UIBarStyleBlackTranslucent;
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                         nil];
    [doneToolbar sizeToFit];
    textView.inputAccessoryView = doneToolbar;
}
-(void)doneButtonClickedDismissKeyboard
{
    [textview endEditing:YES];
    [textview resignFirstResponder];
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

- (IBAction)pageChanged:(id)sender {

//    NSLog(@"***pAGE CHANGED");

    CGFloat x = pageControl.currentPage * imageScrollView.frame.size.width;
    [imageScrollView setContentOffset:CGPointMake(x, 0) animated:YES];


}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textview endEditing:YES];
    [textview resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"***DID SCROLL");
    if (scrollView.isDragging || scrollView.isDecelerating){
        pageControl.currentPage = lround(scrollView.contentOffset.x / (scrollView.contentSize.width /pageControl.numberOfPages));
    }
}
@end
