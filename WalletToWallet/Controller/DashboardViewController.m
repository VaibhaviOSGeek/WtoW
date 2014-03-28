//
//  DashboardViewController.m
//  WalletToWallet
//
//  Created by harish on 02/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * logOutBarButton =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(logOutBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = logOutBarButton;
    
    UIBarButtonItem * myAccount =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mayaaccount.png"] style:UIBarButtonItemStylePlain target:self action:@selector(myAccountButtonClicked)];
    self.navigationItem.rightBarButtonItem = myAccount;
    //mayaaccount.png
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[MyBalanceList instance]getMyBalanceDelegate:self];
  
}
-(void)myAccountButtonClicked{
                                  
}
-(void)rechargedWalletClicked:(id)sender{
    RechageWalletViewController * recharge =[RechageWalletViewController iniViewController];
    [self.navigationController pushViewController:recharge animated:YES];
}
-(void)walletToWalletTransferClicked:(id)sender{
    WalletToWalletViewController * WalletToWallet =[WalletToWalletViewController initViewController];
    [self.navigationController pushViewController:WalletToWallet animated:YES];
}
-(void)reportClicked:(id)sender{
    ReportViewController * recharge =[ReportViewController initViewController];
    [self.navigationController pushViewController:recharge animated:YES];
}
-(void)listConciergeServiceClicked:(id)sender{
    ListConciergeServicesViewController * recharge =[ListConciergeServicesViewController initViewController];
    [self.navigationController pushViewController:recharge animated:YES];
}
-(void)specialOfferClicked:(id)sender{
    SpecialOfferViewController * recharge =[SpecialOfferViewController initViewController];
    [self.navigationController pushViewController:recharge animated:YES];
}
-(void)logOutBarButtonClicked:(id)sender{
    [[AppDelegate appDelegate]logout];
}
#pragma mark -ModelListDelegate
-(void)ModelListLoadedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    _lblMyBalance.text = [MyBalanceList instance].user_balance;
}
-(void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
