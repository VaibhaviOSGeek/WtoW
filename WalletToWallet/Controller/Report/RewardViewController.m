//
//  RewardViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "RewardViewController.h"

@interface RewardViewController ()

@end

@implementation RewardViewController
@synthesize tblReport=_tblReport;
@synthesize reportArray=_reportArray;

+(RewardViewController *)initViewController{
    RewardViewController * recharge =[[RewardViewController alloc]initWithNibName:@"RewardViewController" bundle:[NSBundle mainBundle]];
    recharge.title =@"Reward Report";
    return recharge;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[ReportList instance]getRewardReportList].count <= 0) {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    }
    [[ReportList instance]getRewardReportListByPage:1 Delegate:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_reportArray count];
    
    
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
        RewordReportInfo * rewardInfo =[_reportArray objectAtIndex:indexPath.row];
        [cell setData:rewardInfo];
        
    }
    
    return  cell;
    
}

#pragma mark -ModelListDelegate
-(void)ModelListLoadedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    _reportArray = [[NSMutableArray alloc]init];
      _reportArray =  [[ReportList instance]getRewardReportList];
    [_tblReport reloadData];

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
