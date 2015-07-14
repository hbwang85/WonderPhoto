//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "HTPhotoViewModel.h"
#import "HTPhotoModel.h"
#import "RACSignal.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "NSObject+RACPropertySubscribing.h"
#import "PhotoImporter.h"


@implementation HTPhotoViewModel

- (instancetype)initWithModel:(HTPhotoModel *)photoModel {
    self = [super init];
    if (self) {
        _model = photoModel;
        __weak typeof(self) weakSelf = self;
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            [self downloadPhotoModelDetails];
        }];

        RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
            return [UIImage imageWithData:value];
        }];

    }

    return self;
}

- (NSString *)photoName {
    return self.model.photoName;
}


- (void)downloadPhotoModelDetails {
    _loading = YES;
    [[PhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {

    } completed:^{
        _loading = NO;
    }];

}


@end