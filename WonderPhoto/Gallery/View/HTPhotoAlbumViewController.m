//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "HTPhotoAlbumViewController.h"
#import "HTPhotoAlbumViewModel.h"
#import "HTPhotoModel.h"
#import "HTPhotoViewController.h"
#import "HTPhotoViewModel.h"


@implementation HTPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers:@[[self photoViewControllerForIndex:self.viewModel.initialPhotoIndex]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    self.title = self.viewModel.initialPhotoName;
    self.delegate = self;
    self.dataSource = self;
}

- (HTPhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
    HTPhotoModel *model = [self.viewModel photoModelAtIndex:index];

    if (model) {
        HTPhotoViewModel *photoViewModel = [[HTPhotoViewModel alloc] initWithModel:model];
        HTPhotoViewController *viewController = (HTPhotoViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HTPhotoViewController"];
        viewController.viewModel = photoViewModel;
        viewController.photoIndex = index;

        return viewController;
    }

    return nil;
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.title = ((HTPhotoViewController *)pageViewController.viewControllers.firstObject).viewModel.photoName;


}


#pragma mark - UIPageViewControllerDatasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(HTPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(HTPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex+1];
}


@end