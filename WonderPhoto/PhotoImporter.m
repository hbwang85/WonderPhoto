//
// Created by Haibin Wang on 7/13/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "PhotoImporter.h"
#import "RACSignal.h"
#import "NSURLConnection+RACSupport.h"
#import "PXRequest.h"
#import "RACSignal+Operations.h"
#import "RACScheduler.h"
#import "HTPhotoModel.h"
#import "NSSet+RACSequenceAdditions.h"
#import "RACSequence.h"
#import "HTPhotoModel.h"
#import "RACMulticastConnection.h"
#import "NSArray+RACSequenceAdditions.h"
#import "RACSubscriptingAssignmentTrampoline.h"


@implementation PhotoImporter

+ (RACSignal *)importPhotos {
    return [[[[[self requestPhotoData] deliverOn:[RACScheduler mainThreadScheduler]] map:^id(NSData *value) {
        id results = [NSJSONSerialization JSONObjectWithData:value
                                                     options:0
                                                       error:nil];

        return [[[results[@"photos"] rac_sequence] map:^id(NSDictionary *value) {
            HTPhotoModel *model = [[HTPhotoModel alloc] init];
            [self configurePhotoModel:model withDictionary:value];
            [self downloadThumbnailForPhotoModel:model];
            return model;
        }] array];
    }] publish] autoconnect];
}

+ (void)downloadThumbnailForPhotoModel:(HTPhotoModel *)model {
    RAC(model, thumbnailData) = [self download:model.thumbnailURL];
}

+ (RACSignal *)download:(NSString *)url {
    NSAssert(url, @"url must not be nil");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse *response, NSData *data) {
        return data;
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

+ (void)configurePhotoModel:(HTPhotoModel *)photoModel withDictionary:(NSDictionary *)dictionary {
    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"][@"username"];
    photoModel.rating = dictionary[@"rating"];
    photoModel.thumbnailURL = [self urlForImageSize:3 inDictionary:dictionary[@"images"]];

    if (dictionary[@"voted"]) {
        photoModel.votedFor = [dictionary[@"voted"] boolValue];
    }

    if (dictionary[@"comments_count"]) {
        photoModel.fullsizedURL = [self urlForImageSize:3 inDictionary:dictionary[@"images"]];
    }
}

+ (NSString *)urlForImageSize:(NSInteger)size inDictionary:(NSArray *)array {
    return [[[[[array rac_sequence] filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(id value) {
        return value[@"url"];
    }] array] firstObject];
}

+ (RACSignal *)requestPhotoData {
    NSURLRequest *request = [self populateURLRequest];
    return [[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSURLResponse *response, NSData *data) {
        return data;
    }];
}

+ (NSURLRequest *)populateURLRequest {
    return [[PXRequest apiHelper] urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
                                             resultsPerPage:20
                                                       page:0
                                                 photoSizes:PXPhotoModelSizeThumbnail
                                                  sortOrder:PXAPIHelperSortOrderRating
                                                     except:PXPhotoModelCategoryNude];
}

+(NSURLRequest *)photoURLRequest:(HTPhotoModel *)photoModel {
    return [[PXRequest apiHelper] urlRequestForPhotoID:photoModel.identifier.integerValue];
}

+ (RACSignal *)fetchPhotoDetails:(HTPhotoModel *)model {
    return [[[[[[NSURLConnection rac_sendAsynchronousRequest:[self photoURLRequest:model]] reduceEach:^id(NSURLResponse *response, NSData *data) {
        return data;
    }] map:^id(NSData *value) {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:value
                                                                options:0
                                                                  error:nil][@"photo"];
        [self configurePhotoModel:model withDictionary:results];
        [self downloadFullsizedImageForPhotoModel:model];

        return model;
    }] deliverOn:[RACScheduler mainThreadScheduler]] publish] autoconnect];

}

+(void)downloadFullsizedImageForPhotoModel:(HTPhotoModel *)photoModel {
    RAC(photoModel, fullsizedData) = [self download:photoModel.fullsizedURL];
}

@end