//
//  WalletToWalletViewController.h
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletToWalletViewController : UIViewController
{
    IBOutlet UITextField * _txtFromAccount;
    IBOutlet UITextField * _txtFromAccountName;
    IBOutlet UITextField * _txtActualAmount;
    IBOutlet UITextField * _txtMethod;
    IBOutlet UITextField * _txtCurrency;
    IBOutlet UITextField * _txtToAccount;
    IBOutlet UITextField * _txtToAccountName;
    
}
@property (nonatomic ,retain) UITextField * txtFromAccount;
@property (nonatomic ,retain) UITextField * txtFromAccountName;
@property (nonatomic ,retain) UITextField * txtActualAmount;
@property (nonatomic ,retain) UITextField * txtMethod;
@property (nonatomic ,retain) UITextField * txtCurrency;
@property (nonatomic ,retain) UITextField * txtToAccount;
@property (nonatomic ,retain) UITextField * txtToAccountName;



+(WalletToWalletViewController *)initViewController;

- (IBAction)submitClicked:(id)sender;
@end
