//
//  LoginViewController.h
//  WonderPhoto
//
//  Created by Haibin Wang on 7/7/15.
//  Copyright (c) 2015 Haibin Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewModel;

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic, strong) LoginViewModel *viewModel;

@end
