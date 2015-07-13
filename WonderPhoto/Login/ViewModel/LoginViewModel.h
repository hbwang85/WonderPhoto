//
// Created by Haibin Wang on 7/7/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMViewModel.h"

@class RACCommand;

@interface LoginViewModel : RVMViewModel

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *passwd;
@property(readonly, strong) RACCommand *loginCommand;

@end