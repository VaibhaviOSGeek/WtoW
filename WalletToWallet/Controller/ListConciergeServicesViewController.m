//
//  ListConciergeServicesViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "ListConciergeServicesViewController.h"

@interface ListConciergeServicesViewController ()

@end

@implementation ListConciergeServicesViewController

+(ListConciergeServicesViewController *)initViewController{
    ListConciergeServicesViewController * recharge =[[ListConciergeServicesViewController alloc]initWithNibName:@"ListConciergeServicesViewController" bundle:[NSBundle mainBundle]];
    recharge.title =@"Concierge Services";
    return recharge;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
