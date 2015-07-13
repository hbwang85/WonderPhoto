//
// Created by Haibin Wang on 7/7/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "LoginViewModel.h"
#import "RACCommand.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "NSObject+RACPropertySubscribing.h"


@implementation LoginViewModel

- (instancetype)init{
    self = [super init];

    if (self) {
        _loginCommand = [[RACCommand alloc] initWithEnabled:[self validateloginInputs] signalBlock:^RACSignal *(id input) {
            self.active = YES;
            return [RACSignal empty];
        }];
    }

    return self;
}

- (RACSignal *)validateloginInputs {
    return [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, passwd)] reduce:^id {
        return @(_userName.length>0 && _passwd.length>0);
    }];
}

@end