//
//  ReportTableCell.h
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewordReportInfo.h"
@interface ReportTableCell : UITableViewCell
{
    IBOutlet UILabel * _lblDate;
    IBOutlet UILabel * _lblDec;
    IBOutlet UILabel * _lblTrasectionId;
    IBOutlet UILabel * _lblamount;
    IBOutlet UILabel * _lblPoint;
   
}
@property (nonatomic ,retain) UILabel * lblDate;
@property (nonatomic ,retain) UILabel * lblDec;
@property (nonatomic ,retain) UILabel * lblTrasectionId;
@property (nonatomic ,retain) UILabel * lblamount;
@property (nonatomic ,retain) UILabel * lblPoint;

- (void)setData:(RewordReportInfo *)reward;
@end
