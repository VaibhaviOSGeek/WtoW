//
//  ForgotPasswordViewController.m
//  WalletToWallet
//
//  Created by harish on 05/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize txtEmail=_txtEmail;

+(ForgotPasswordViewController *)initViewController{
    ForgotPasswordViewController * forgot =[[ForgotPasswordViewController alloc]initWithNibName:@"ForgotPasswordViewController" bundle:[NSBundle mainBundle]];
    forgot.title =@"Forgot";
    return forgot;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * logOutBarButton =[[UIBarButtonItem alloc]initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(logOutBarButtonClicked:)];
    self.navigationItem.leftBarButtonItem = logOutBarButton;
   
    
    // Do any additional setup after loading the view from its nib.
}
-(void)logOutBarButtonClicked:(id)sender{
      self.navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)submitClicked:(id)sender{
    if (!(_txtEmail.text.length > 0)) {
    
        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter valid email!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }else{
        if (![Utility validateEmailWithString:_txtEmail.text]) {
            UIAlertView * alert= [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter valid email!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            _txtEmail.text=@"";
            return;
            
        }
        
        
        

    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
