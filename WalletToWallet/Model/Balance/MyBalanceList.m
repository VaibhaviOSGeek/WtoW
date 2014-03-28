//
//  MyBalanceList.m
//  WalletToWallet
//
//  Created by harish on 20/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "MyBalanceList.h"
static MyBalanceList * Singleton =nil;
@implementation MyBalanceList
@synthesize user_balance=_user_balance;
@synthesize formatted_balance=_formatted_balance;
@synthesize user_currency=_user_currency;
/*
 user_balance: "37472.5"
 formatted_balance: "&#8358;37,472.50"
 user_currency: "NGN"
 */

+(MyBalanceList *)instance{
    if (Singleton == nil) {
        Singleton = [[MyBalanceList alloc]init];
    }
    return Singleton;
}
-(void)getMyBalanceDelegate:(id<ModelListDelegate>)delegate{
    _modelListDelegate=delegate;
    WalletToWalletRequest * request =[[WalletToWalletRequest alloc]initWithApiMethod:BALANCE andDelegate:self andMethod:POST];
    WalletToWalletAccount * account =[AccountManager Instance].activeAccount;
    [request setParameter:[NSNumber numberWithInt:17] forKey:@"uid"];
    request.Tag = BALANCE;
    [request startRequest];
}

#pragma mark -WalletToWalletRequestDelegate
-(void)WalletToWalletRequestDidSucceed:(WalletToWalletRequest *)request{
    if ([request.Tag  isEqual: BALANCE]) {
        NSDictionary * mainDict=[request.responseData objectForKey:@"parameters"];
        if ([mainDict objectForKey:@"user_balance"]) {
            _user_balance =[mainDict objectForKey:@"user_balance"];
        }
        if ([mainDict objectForKey:@"formatted_balance"]) {
            _formatted_balance =[mainDict objectForKey:@"formatted_balance"];
        }
        if ([mainDict objectForKey:@"user_currency"]) {
            _user_currency =[mainDict objectForKey:@"user_currency"];
        }
       
    }    if (_modelListDelegate && [_modelListDelegate respondsToSelector:@selector(ModelListLoadedSuccessfully)]) {
        [_modelListDelegate ModelListLoadedSuccessfully];
    }
    
}
-(void)WalletToWalletRequestDidFail:(WalletToWalletRequest *)request withError:(NSError *)error{
    if (_modelListDelegate && [_modelListDelegate respondsToSelector:@selector(ModelListLoadFailWithError:)]) {
        [_modelListDelegate ModelListLoadFailWithError:request.message];
        
    }
}


@end
