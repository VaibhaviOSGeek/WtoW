//
//  WalletReportViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "WalletReportViewController.h"

@interface WalletReportViewController ()

@end

@implementation WalletReportViewController
@synthesize tblView=_tblView;
@synthesize reportArray=_reportArray;

+(WalletReportViewController *)initViewController{
    WalletReportViewController * recharge =[[WalletReportViewController alloc]initWithNibName:@"WalletReportViewController" bundle:[NSBundle mainBundle]];
    recharge.title =@"Wallet Report";
    return recharge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _reportArray =[[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
    
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
    }
    
    return  cell;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
