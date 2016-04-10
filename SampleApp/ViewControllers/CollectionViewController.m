//
//  CollectionViewController.m
//  SampleApp

#import "CollectionViewCell.h"
#import "CollectionViewController.h"

@interface CollectionViewController () {

    // instance variable to set download url from which image will be downloaded.
    NSString *downloadUrl;

    // Queue to download images asynchronously in background.
    dispatch_queue_t queue;

    IBOutlet UICollectionView *imageCollectionView;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - View Lifecycle methods
- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    // Set URL from which images are to be downloaded.
    downloadUrl =  @"http://maxcdn.photoshoplady.com/wp-content/uploads/2011/12/Amazing-Creation-of-a-Natural-Scenery-L.png";

    queue = dispatch_queue_create("imageList", NULL);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];

    // Download image on background thread
        dispatch_async(queue, ^{
            NSData* photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:downloadUrl]];
            UIImage* image = [UIImage imageWithData:photoData];
            // Once we get the image data, update the UI on the main thread
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imageview.image = image;
            });
            ;
            
        });
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // Set width and height of CollectionViewCell
    return CGSizeMake(100, 100);
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
