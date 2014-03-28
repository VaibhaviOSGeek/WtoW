//
//  RewardCurrencyReportViewController.h
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportTableCell.h"
#import "RewordReportInfo.h"
#import "ActivityIndicator.h"
#import "ReportList.h"

@interface RewardCurrencyReportViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView * _tblRewardCurrency;
    NSMutableArray * _rewardCurrencyArray;
}
@property (nonatomic ,retain) UITableView * tblRewardCurrency;
@property (nonatomic ,retain) NSMutableArray * rewardCurrencyArray;
+(RewardCurrencyReportViewController *)initViewController;
@end
