//
//  Utility.m
//  WalletToWallet
//
//  Created by harish on 05/03/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
