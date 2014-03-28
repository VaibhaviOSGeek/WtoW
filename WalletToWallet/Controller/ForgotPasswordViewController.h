//
//  ForgotPasswordViewController.h
//  WalletToWallet
//
//  Created by harish on 05/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Utility.h"
#import "AppDelegate.h"
@interface ForgotPasswordViewController : UIViewController
{
    IBOutlet UITextField * _txtEmail;
}

+ (ForgotPasswordViewController *)initViewController;

@property (nonatomic ,retain) UITextField * txtEmail;

- (IBAction)submitClicked:(id)sender;
-(void)logOutBarButtonClicked:(id)sender;
@end
