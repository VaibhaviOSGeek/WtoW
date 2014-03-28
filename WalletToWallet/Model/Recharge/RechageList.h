//
//  RechageList.h
//  WalletToWallet
//
//  Created by harish on 18/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WalletToWalletRequest.h"
#import "Constant.h"
#import "WalletToWalletURLSchema.h"
#import "WalletToWalletRequestDelegate.h"
#import "ModelListDelegate.h"
#import "AccountManager.h"
#import "RechageInfo.h"
@interface RechageList : NSObject<WalletToWalletRequestDelegate>
{
    id<ModelListDelegate> _modelListDelegate;
    NSMutableArray * _rechangeArray;
}
@property (nonatomic ,retain) id<ModelListDelegate> modelListDelegate;
@property (nonatomic ,retain) NSMutableArray * rechangeArray;

+ (RechageList *)instance;
- (NSMutableArray *)getRechangeList;
- (void)getMyBalanceByUserId:(id<ModelListDelegate>)delegate;
- (void)rechargeWalletByAmount:(float)amount ModelDelegate:(id<ModelListDelegate>)delegate;
@end
