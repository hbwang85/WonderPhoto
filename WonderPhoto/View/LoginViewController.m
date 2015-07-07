//
//  LoginViewController.m
//  WonderPhoto
//
//  Created by Haibin Wang on 7/7/15.
//  Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <ReactiveCocoa/RACSignal.h>
#import "LoginViewController.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "UITextField+RACSignalSupport.h"
#import "LoginViewModel.h"
#import "RACCommand.h"
#import "RACStream.h"
#import "UIButton+RACCommandSupport.h"
#import "RACSignal+Operations.h"
#import "UIControl+RACSignalSupport.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RAC(self.viewModel, userName) = self.nameField.rac_textSignal;
    RAC(self.viewModel, passwd) = self.passwdField.rac_textSignal;

    self.loginButton.rac_command = self.viewModel.loginCommand;

    __weak typeof(self) weakSelf = self;
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.nameField.rac_textSignal, self.passwdField.rac_textSignal] reduce:^(NSString *username, NSString *passwd) {
        return @(username.length>0 && passwd.length>0);
    }];

    RAC(self.loginButton, backgroundColor) = [RACObserve(self.loginButton, enabled) map:^(NSNumber * value) {
        return  value.boolValue ? [UIColor colorWithRed:61/255.0 green:154/255.0 blue:218/255.0 alpha:1] : [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];
    }];

    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        NSLog(@"clicked....");
    }];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
