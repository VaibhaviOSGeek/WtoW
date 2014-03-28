//
//  RegistrationViewController.m
//  WalletToWallet
//
//  Created by harish on 03/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize txtEmail=_txtEmail;
@synthesize txtFirstName=_txtFirstName;
@synthesize txtLastName=_txtLastName;
@synthesize txtPhone=_txtPhone;
@synthesize txtPassword=_txtPassword;
@synthesize txtUserName=_txtUserName;
@synthesize selectedGender=_selectedGender;
@synthesize confirmPassword=_confirmPassword;
@synthesize txtDateOfBirth=_txtDateOfBirth;

+(RegistrationViewController *)initViewController{
    RegistrationViewController * registrationViewController =[[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
    registrationViewController.title =@"Registration";
    return registrationViewController;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    UIBarButtonItem * logOutBarButton =[[UIBarButtonItem alloc]initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(loginView:)];
    self.navigationItem.leftBarButtonItem = logOutBarButton;

}
-(void)loginView:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)genderSelectClicked:(id)sender{
        ToggleButton *t =sender;
        switch (t.tag)
        {
            case 1:
               _selectedGender =@"male";
                break;
            case 2:
               _selectedGender =@"female";
                break;
        }
    
 }

-(void)submitClicked:(id)sender{
    if (_txtFirstName.text.length <=0 && _txtLastName.text.length <= 0 && _txtEmail.text.length <= 0 && _txtPhone.text.length <= 0) {
        
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter full fill information." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }else{
    
        RegistrationInfo * reg =[[RegistrationInfo alloc]init];
        reg.firstName = _txtFirstName.text;
        reg.lastName = _txtLastName.text;
        reg.username = _txtUserName.text;
        reg.password = _txtPassword.text;
        reg.gender = _selectedGender;
        reg.phoneNumber = _txtPhone.text;
        reg.email = _txtEmail.text;
        
        
        
    }
    

}

-(void)selectDOBClicked:(id)sender{
   
    _pickerContainer = [[UIActionSheet alloc] initWithTitle:@"Date of Birth" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Done",nil];
    
    CGRect pickerFrame = CGRectMake(0,180, 0,200);
    _pickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    _pickerView.datePickerMode = UIDatePickerModeDate;
    _pickerView.date = [NSDate date];
    [_pickerView addTarget:self
                   action:@selector(dateBirthChange:)
         forControlEvents:UIControlEventValueChanged];
     _pickerContainer.tag = 10;
    _pickerContainer.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [_pickerContainer addSubview:_pickerView];
    [_pickerContainer showInView:self.view];
    [_pickerContainer setBounds:CGRectMake(0,0,320,550)];}

-(void)dateBirthChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    _txtDateOfBirth.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:_pickerView.date]];
}


#pragma mark -UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1000) {
        // Email
        
        if (_txtEmail.text.length>0) {
            if (![Utility validateEmailWithString:textField.text]) {
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter valid Email Address!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
                _txtEmail.text=@"";
            }
   
        }
    }else{
        if (_txtPassword.text.length > 0 && _confirmPassword.text.length > 0) {
            if (![_txtPassword.text isEqual:_confirmPassword.text]) {
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Password does not match!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
                 _txtPassword.text=@"";
                _confirmPassword.text=@"";
            }
        }
    }
}
#pragma mark -UniversalDelegate
-(void)DataPostToServerSuccessfully:(WalletToWalletRequest *)responce{
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:[responce.responseData objectForKey:@"description"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
}

-(void)DataPostToServerFailWithError:(NSString *)error{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
