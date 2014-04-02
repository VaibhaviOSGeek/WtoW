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
    if ([[ReportList instance]getRewardCurrencyList].count <= 0) {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    }
    [[ReportList instance]getRewardCurrencyListByPage:1 Delegate:self];
    
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rewardCurrencyArray count];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    RewordReportInfo * rewardInfo =[_rewardCurrencyArray objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize title_size = [rewardInfo.description sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize c_size=CGSizeMake(320, title_size.height+2 + 31 + 30);
    return c_size.height;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RewardCurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"RewardCurrencyCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (RewardCurrencyCell*) currentObject;
            }
        }
        RewordReportInfo * rewardInfo =[_rewardCurrencyArray objectAtIndex:indexPath.row];
        [cell setData:rewardInfo];
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        
        CGSize Descriptionsize = [rewardInfo.description sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        
        [cell.lblDec setFrame:CGRectMake(CELL_CONTENT_MARGIN,cell.lblDec.frame.origin.y, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),Descriptionsize.height)];
        
        [cell.containerView setFrame:CGRectMake(5,cell.lblDec.frame.size.height + 36,cell.containerView.frame.size.width,cell.containerView.frame.size.height)];
        
        
        [cell.view setFrame:CGRectMake(5,1,cell.frame.size.width-10,cell.lblDec.frame.size.height +31+30)];
        
        [cell setFrame:CGRectMake(0,0,320,cell.view.frame.size.height)];
        [cell setFrame:CGRectMake(0,0,320,cell.frame.size.height)];
        
        
    }
    
    return  cell;
}

#pragma mark -ModelListDelegate
-(void)ModelListLoadedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    _rewardCurrencyArray = [[NSMutableArray alloc]init];
    _rewardCurrencyArray =  [[ReportList instance]getRewardCurrencyList];
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
