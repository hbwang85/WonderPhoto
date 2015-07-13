//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "GalleryViewModel.h"
#import "RACSignal.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "PhotoImporter.h"
#import "RACSignal+Operations.h"


@implementation GalleryViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        RAC(self, models) = [self importPhotosSignal];
    }

    return self;
}

- (RACSignal *)importPhotosSignal {

    return [[[PhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
}


@end