//
// Created by Haibin Wang on 7/9/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <ReactiveCocoa/RACSignal.h>
#import "GalleryCell.h"
#import "HTPhotoModel.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "NSObject+RACPropertySubscribing.h"
#import "NSData+AFDecompression.h"
#import "RACSubscriber.h"
#import "RACSignal+Operations.h"
#import "RACScheduler.h"
#import "UIImageView+WebCache.h"


@implementation GalleryCell 

- (void)awakeFromNib {
    [super awakeFromNib];

//    __weak typeof(self) weakSelf = self;
//    [[RACObserve(self, photoModel) ignore:nil] map:^id(HTPhotoModel * value) {
//        [weakSelf.avatar sd_setImageWithURL:[NSURL URLWithString:value.thumbnailURL]];
//        return [RACSignal empty];
//    }];

    RAC(self.avatar, image) = [[[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
        return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [value af_decompressedImageFromJPEGDataWithCallback:^(UIImage *decompressedImage) {
                [subscriber sendNext:decompressedImage];
                [subscriber sendCompleted];
            }];
            return nil;
        }] subscribeOn:[RACScheduler scheduler]];
    }] switchToLatest];

}




//- (void)setPhotoModel:(HTPhotoModel *)photoModel {
//    _photoModel = photoModel;
//    [self.avatar sd_setImageWithURL:[NSURL URLWithString:photoModel.thumbnailURL]];
//}


@end