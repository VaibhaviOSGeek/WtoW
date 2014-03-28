//
//  RechageList.m
//  WalletToWallet
//
//  Created by harish on 18/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "RechageList.h"
static RechageList * Singleton =nil;
@implementation RechageList
+(RechageList *)instance{
    if (Singleton == nil) {
        Singleton = [[RechageList alloc]init];
    }
    return Singleton;
}

-(id)init
{self = [super init];
    if (self) {
        _rechangeArray=[[NSMutableArray alloc]init];
        _modelListDelegate=nil;
    }
    return self;
}
-(NSMutableArray *)getRechangeList{
    return _rechangeArray;
}

-(void)rechargeWalletByAmount:(float)amount ModelDelegate:(id<ModelListDelegate>)delegate{
    _modelListDelegate =delegate;
    
    WalletToWalletRequest * request =[[WalletToWalletRequest alloc]initWithApiMethod:WALLET_RECHARGE_CHARGES andDelegate:self andMethod:POST];
    WalletToWalletAccount * account =[AccountManager Instance].activeAccount;
    [request setParameter:[NSNumber numberWithInt:17] forKey:@"uid"];
    [request setParameter:[NSNumber numberWithFloat:amount] forKey:@"amount"];
    request.Tag = WALLET_RECHARGE_CHARGES;
    [request startRequest];
}

#pragma mark -WalletToWalletRequestDelegate
-(void)WalletToWalletRequestDidSucceed:(WalletToWalletRequest *)request{
    if ([request.Tag  isEqual: BALANCE]) {
        
    }else if ([request.Tag isEqual:WALLET_RECHARGE_CHARGES]){
        _rechangeArray =[[NSMutableArray alloc]init];
        NSDictionary * mainDict=[request.responseData objectForKey:@"parameters"];
        
        NSArray* array = [mainDict objectForKey:@"charges"];
        
        if (array && array.count >0) {
            for (NSDictionary * rewardDict in array) {
                RechageInfo * recharge =[RechageInfo parseWithDictionary:rewardDict];
                [_rechangeArray addObject:recharge];
            }
        }
    }
    if (_modelListDelegate && [_modelListDelegate respondsToSelector:@selector(ModelListLoadedSuccessfully)]) {
        [_modelListDelegate ModelListLoadedSuccessfully];
        
    }
    

}
-(void)WalletToWalletRequestDidFail:(WalletToWalletRequest *)request withError:(NSError *)error{
    if (_modelListDelegate && [_modelListDelegate respondsToSelector:@selector(ModelListLoadFailWithError:)]) {
        [_modelListDelegate ModelListLoadFailWithError:request.message];
        
    }
}

@end
