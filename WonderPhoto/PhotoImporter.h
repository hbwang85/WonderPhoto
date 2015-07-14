//
// Created by Haibin Wang on 7/13/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class HTPhotoModel;


@interface PhotoImporter : NSObject
+ (RACSignal *)importPhotos;

+ (RACSignal *)fetchPhotoDetails:(HTPhotoModel *)model;
@end