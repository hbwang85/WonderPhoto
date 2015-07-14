//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMViewModel.h"

@class HTPhotoModel;


@interface HTPhotoViewModel : RVMViewModel

@property(nonatomic, readonly) HTPhotoModel *model;
@property(nonatomic, readonly) NSString *photoName;
@property(nonatomic, readonly) UIImage *photoImage;
@property(nonatomic, readonly, getter=isLoading) BOOL loading;

- (instancetype)initWithModel:(HTPhotoModel *)photoModel;

@end