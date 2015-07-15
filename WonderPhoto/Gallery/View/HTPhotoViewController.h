//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTPhotoViewModel;


@interface HTPhotoViewController : UIViewController

@property(nonatomic, assign) NSInteger photoIndex;
@property(nonatomic, strong) HTPhotoViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end