//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "HTPhotoAlbumViewModel.h"
#import "HTPhotoModel.h"


@implementation HTPhotoAlbumViewModel
- (instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex {
    self = [super init];
    if (self) {
        _models = photoArray;
        _initialPhotoIndex = initialPhotoIndex;
    }
    return self;
}

- (HTPhotoModel *)photoModelAtIndex:(NSInteger)index {
    if (index<0 || index>self.models.count-1) {
        return nil;
    } else {
        return self.models[index];
    }
}

- (NSString *)initialPhotoName {

    return [[self initialPhotoModel] photoName];
}

- (HTPhotoModel *)initialPhotoModel {
    return self.models[self.initialPhotoIndex];
}


@end