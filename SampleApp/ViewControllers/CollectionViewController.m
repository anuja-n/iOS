//
//  CollectionViewController.m
//  SampleApp
//
//  Created by Saurabh on 09/04/16.
//  Copyright © 2016 Extentia Information Technology. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionViewController.h"

@interface CollectionViewController () {
    NSString *downloadUrl;
    dispatch_queue_t queue;
    IBOutlet UICollectionView *imageCollectionView;
    NSMutableArray *downloadedImagesArray;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    imageCollectionView.backgroundColor = [UIColor clearColor];
    imageCollectionView.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor whiteColor];
   downloadUrl =  @"http://maxcdn.photoshoplady.com/wp-content/uploads/2011/12/Amazing-Creation-of-a-Natural-Scenery-L.png";
    queue = dispatch_queue_create("imageList", NULL);

    downloadedImagesArray = [[NSMutableArray alloc]init];
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

        NSLog(@"***Downloading");
        dispatch_async(queue, ^{
            NSData* photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:downloadUrl]];
            UIImage* image = [UIImage imageWithData:photoData];


            // Once we get the data, update the UI on the main thread
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imageview.image = image;
            });
            ;
            
        });
    // Start getting the data in the background
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
