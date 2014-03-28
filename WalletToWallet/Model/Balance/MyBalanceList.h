//
//  MyBalanceList.h
//  WalletToWallet
//
//  Created by harish on 20/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalletToWalletRequest.h"
#import "Constant.h"
#import "WalletToWalletURLSchema.h"
#import "WalletToWalletRequestDelegate.h"
#import "ModelListDelegate.h"
#import "AccountManager.h"

@interface MyBalanceList : NSObject<WalletToWalletRequestDelegate>
{
    id<ModelListDelegate> _modelListDelegate;
    NSString * _user_balance;
    NSString * _formatted_balance;
    NSString * _user_currency;


}
@property (nonatomic ,retain) id<ModelListDelegate> modelListDelegate;
@property (nonatomic ,retain) NSString * user_balance;
@property (nonatomic ,retain) NSString * formatted_balance;
@property (nonatomic ,retain) NSString * user_currency;

+ (MyBalanceList *)instance;
- (void)getMyBalanceDelegate:(id<ModelListDelegate>)delegate;


@end
