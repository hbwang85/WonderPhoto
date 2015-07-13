//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryCell.h"
#import "GalleryViewModel.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"

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
    }];

}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"item count:%i", self.viewModel.models.count);
    return self.viewModel.models.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.photoModel = self.viewModel.models[indexPath.row];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
}


@end