//
//  RewardCurrencyReportViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "RewardCurrencyReportViewController.h"

@interface RewardCurrencyReportViewController ()

@end

@implementation RewardCurrencyReportViewController
@synthesize rewardCurrencyArray=_rewardCurrencyArray;
@synthesize tblRewardCurrency=_tblRewardCurrency;

+(RewardCurrencyReportViewController *)initViewController{
    RewardCurrencyReportViewController * recharge =[[RewardCurrencyReportViewController alloc]initWithNibName:@"RewardCurrencyReportViewController" bundle:[NSBundle mainBundle]];
    recharge.title =@"Reward Currency Report";
    return recharge;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[ReportList instance]getRewardReportList].count <= 0) {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    }
    [[ReportList instance]getRewardReportListByPage:1 Delegate:self];
    
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rewardCurrencyArray count];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    ReportTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"ReportTableCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (ReportTableCell*) currentObject;
            }
        }
        RewordReportInfo * rewardInfo =[_rewardCurrencyArray objectAtIndex:indexPath.row];
        [cell setData:rewardInfo];
        
    }
    
    return  cell;
    
}

#pragma mark -ModelListDelegate
-(void)ModelListLoadedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    _rewardCurrencyArray = [[NSMutableArray alloc]init];
    _rewardCurrencyArray =  [[ReportList instance]getRewardReportList];
    [_tblRewardCurrency reloadData];
    
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
