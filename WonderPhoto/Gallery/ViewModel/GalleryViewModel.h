//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVMViewModel.h"


@interface GalleryViewModel : RVMViewModel

@property(nonatomic, strong, readonly) NSArray *models;

- (instancetype)init;

@end