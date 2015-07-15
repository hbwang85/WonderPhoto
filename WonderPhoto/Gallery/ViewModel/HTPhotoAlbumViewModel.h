//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVMViewModel.h"

@class HTPhotoModel;


@interface HTPhotoAlbumViewModel : RVMViewModel

- (instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex;
- (HTPhotoModel *)photoModelAtIndex:(NSInteger)index;


@property(nonatomic, readonly, strong) NSArray *models;
@property(nonatomic, assign, readonly) NSInteger initialPhotoIndex;
@property(nonatomic, readonly, strong) NSString *initialPhotoName;


@end