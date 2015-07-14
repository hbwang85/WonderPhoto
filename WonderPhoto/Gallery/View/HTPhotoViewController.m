//
// Created by Haibin Wang on 7/14/15.
// Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import "HTPhotoViewController.h"
#import "HTPhotoViewModel.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal.h"
#import "SVProgressHUD.h"


@implementation HTPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RAC(self.photoView, image) = RACObserve(self.viewModel, photoImage);

    [RACObserve(self.viewModel, active) subscribeNext:^(NSNumber *x) {
        if (x.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.viewModel.active = YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    self.viewModel.active = NO;
}



@end