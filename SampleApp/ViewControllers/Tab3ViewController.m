//
//  Tab3ViewController.m
//  SampleApp
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

#pragma mark - View Lifecycle methods

- (void)viewDidLoad {

    [super viewDidLoad];

    // Initialize array with 3 static image names.
    imageArray = [[NSArray alloc]initWithObjects:@"image1",@"image2",@"image3", nil];

    [imageScrollView setCanCancelContentTouches:NO];
    imageScrollView.clipsToBounds = NO;
    imageScrollView.scrollEnabled = YES;
    imageScrollView.pagingEnabled = YES;

    [self addImagesToScrollview];

    [textview setDataDetectorTypes:UIDataDetectorTypeAll];
    [self addDoneToolBarToKeyboard:textview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Class Methods

/*!
 @method     addImagesToScrollview
 @abstract   This method adds static images to scrollview and sets contentsize
             of scrollview accordingly.
 @params     nil
 */
- (void)addImagesToScrollview {

    NSUInteger count;
    CGFloat xOrigin = 0;
    for (count=0;count <3; count++) {

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

/*!
 @method     addDoneToolBarToKeyboard
 @abstract   This method adds Toolbar with Done button to keyboard.
 @params     (UITextView *)textView
 */
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

/*!
 @method     doneButtonClickedDismissKeyboard
 @abstract   This method dismisses keyboard when tapped on done button of
            toolbar and also when tapped outside of textview
 @params     nil
 */
-(void)doneButtonClickedDismissKeyboard
{
    [textview endEditing:YES];
    [textview resignFirstResponder];
}

# pragma mark- IBAction methods
- (IBAction)pageChanged:(id)sender {

//    NSLog(@"***pAGE CHANGED");

    CGFloat x = pageControl.currentPage * imageScrollView.frame.size.width;
    [imageScrollView setContentOffset:CGPointMake(x, 0) animated:YES];


}

# pragma mark - Gesture recognizer methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textview endEditing:YES];
    [textview resignFirstResponder];
}

# pragma mark - ScrollViewDelegate methods.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"***DID SCROLL");
    if (scrollView.isDragging || scrollView.isDecelerating){
        pageControl.currentPage = lround(scrollView.contentOffset.x / (scrollView.contentSize.width /pageControl.numberOfPages));
    }
}
@end
