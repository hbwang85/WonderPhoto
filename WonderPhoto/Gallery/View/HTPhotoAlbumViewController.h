//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTPhotoAlbumViewModel;


@interface HTPhotoAlbumViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>


@property(nonatomic, strong) HTPhotoAlbumViewModel *viewModel;



@end