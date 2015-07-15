//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCell.h"
#import "GalleryViewModel.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"
#import "HTPhotoAlbumViewController.h"
#import "HTPhotoAlbumViewModel.h"
#import "HTPhotoModel.h"
#import "SVProgressHUD.h"

static NSString *const cellIdentifier = @"GalleryCellIdentifier";


@interface GalleryViewController()

@property(nonatomic, strong) GalleryViewModel *viewModel;

@end


@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Popular";
    self.viewModel = [[GalleryViewModel alloc] init];

    __weak typeof(self) weakSelf = self;
    [RACObserve(self.viewModel, models) subscribeNext:^(id x) {
        [weakSelf.collectionView reloadData];
        [SVProgressHUD dismiss];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SVProgressHUD show];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.models.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.photoModel = self.viewModel.models[indexPath.row];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];

    [self performSegueWithIdentifier:@"showPhotoAlbum" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"showPhotoAlbum"]) {
        HTPhotoAlbumViewModel *viewModel = [[HTPhotoAlbumViewModel alloc] initWithPhotoArray:self.viewModel.models
                                                                           initialPhotoIndex:((NSIndexPath *)sender).row];

        HTPhotoAlbumViewController *controller = (HTPhotoAlbumViewController *)segue.destinationViewController;
        controller.viewModel = viewModel;
    }
}


@end