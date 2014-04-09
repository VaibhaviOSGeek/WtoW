//
//  WalletToWalletViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "WalletToWalletViewController.h"

@interface WalletToWalletViewController ()

@end

@implementation WalletToWalletViewController
@synthesize txtActualAmount=_txtActualAmount;
@synthesize txtCurrency=_txtCurrency;
@synthesize txtMethod=_txtMethod;
@synthesize txtFromAccount=_txtFromAccount;
@synthesize txtFromAccountName=_txtFromAccountName;
@synthesize txtToAccount=_txtToAccount;
@synthesize txtToAccountName=_txtToAccountName;

+(WalletToWalletViewController *)initViewController{
   //WalletToWalletViewController_iPad
    WalletToWalletViewController * recharge;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        recharge =[[WalletToWalletViewController alloc]initWithNibName:@"WalletToWalletViewController_iPad" bundle:[NSBundle mainBundle]];

    }
    else
    {
        recharge =[[WalletToWalletViewController alloc]initWithNibName:@"WalletToWalletViewController" bundle:[NSBundle mainBundle]];

    }
        recharge.title =@"Wallet To Wallet";
    return recharge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)submitClicked:(id)sender{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
