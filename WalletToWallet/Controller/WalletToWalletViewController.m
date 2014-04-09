//
//  WalletToWalletViewController.m
//  WalletToWallet
//
//  Created by harish on 04/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "WalletToWalletViewController.h"

@interface WalletToWalletViewController ()

@end

@implementation WalletToWalletViewController
@synthesize txtActualAmount=_txtActualAmount;
@synthesize txtCurrency=_txtCurrency;
@synthesize txtMethod=_txtMethod;
@synthesize txtFromAccount=_txtFromAccount;
@synthesize txtFromAccountName=_txtFromAccountName;
@synthesize txtToAccount=_txtToAccount;
@synthesize txtToAccountName=_txtToAccountName;
@synthesize scrollView=_scrollView;

+(WalletToWalletViewController *)initViewController{
    WalletToWalletViewController * recharge =[[WalletToWalletViewController alloc]initWithNibName:@"WalletToWalletViewController" bundle:[NSBundle mainBundle]];
    recharge.title =@"Wallet To Wallet";
    return recharge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    methodArray = [[NSMutableArray alloc]initWithObjects:@"Pay Using Card", nil];
    currencyArray = [[NSMutableArray alloc]initWithObjects:@"NGN", nil];
    CGSize size =  CGSizeMake(320, 800.0);
    [self.scrollView setContentSize:size];

    // Do any additional setup after loading the view from its nib.
}
-(void)methodClicked:(id)sender{
    _pickerContainer = [[UIActionSheet alloc] initWithTitle:@"Method" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Done",nil];
    
    CGRect pickerFrame = CGRectMake(0,180, 0,200);
    _pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    _pickerContainer.tag = 1000;
    _pickerView.tag = 1000;
    _pickerView.delegate =self;
    _pickerView.dataSource=self;
    _pickerContainer.delegate= self;
    _pickerContainer.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [_pickerContainer addSubview:_pickerView];
    [_pickerContainer showInView:self.view];
    [_pickerContainer setBounds:CGRectMake(0,0,320,550)];
}

-(void)curencyClicked:(id)sender{
    
    _pickerContainer = [[UIActionSheet alloc] initWithTitle:@"Currency" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Done",nil];
    
    CGRect pickerFrame = CGRectMake(0,180, 0,200);
    _pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    _pickerContainer.tag = 1001;
    _pickerView.tag = 1001;
    _pickerView.delegate =self;
    _pickerView.dataSource=self;
    _pickerContainer.delegate= self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerContainer.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [_pickerContainer addSubview:_pickerView];
    [_pickerContainer showInView:self.view];
    [_pickerContainer setBounds:CGRectMake(0,0,320,550)];}




-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView.tag == 1000) {
        // Mrthod
        return [methodArray count];
    }else{
        //Currency
        return [currencyArray count];
    }
    return 0;
    
}

// Display each row's data
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    if (pickerView.tag == 1000) {
        // Mrthod
        str = [methodArray objectAtIndex: row];
    }else{
        //Currency
        str = [currencyArray objectAtIndex: row];
    }
    return str;
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    PickerActiveIdx = row;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if (actionSheet.tag == 1000) {
            // Method
            _txtMethod.text = [methodArray objectAtIndex:PickerActiveIdx];
        }else{
            _txtCurrency.text = [currencyArray objectAtIndex:PickerActiveIdx];
        }
        
        //done
    }
}
-(void)submitClicked:(id)sender{
//uid=17&account_no=WE-17-3692&account_name=Jack+Martin&currency=NGN&actual_amount=20&to_account_no=WE-17-3611&total_amount=38&account_pin=6436
    if (_txtActualAmount.text.length > 0) {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Account Pin" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
        alertView.tag = 2;
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alertView show];
    }else{
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter Recharge amount.!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }

    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    _pinNumber = alertTextField.text;
    
    [[RechageList instance]transfer_fund_confirmAccount_no:_txtToAccount.text AccountName:_txtToAccountName.text Currency:_txtCurrency.text ActualAmount:_txtActualAmount.text to_account_no:_txtFromAccount.text TotalAmount:[MyBalanceList instance].user_balance account_pin:alertTextField.text ModelDelegate:self];
     
    
    NSLog(@"alerttextfiled - %@",alertTextField.text);
    
    // do whatever you want to do with this UITextField.
}
-(void)clearAllData{
   
    _txtActualAmount.text =@"";
    _txtFromAccount.text =@"";
    _txtFromAccountName.text =@"";
    _txtToAccountName.text =@"";
    _txtCurrency.text =@"";
    _txtActualAmount.text =@"";
    _txtCurrency.text =@"";
    _txtMethod.text =@"";
}
#pragma mark -ModelListDelegate
-(void)ModelListLoadedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [self clearAllData];

    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    [self clearAllData];
    UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
