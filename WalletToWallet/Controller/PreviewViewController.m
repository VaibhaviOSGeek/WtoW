//
//  PreviewViewController.m
//  WalletToWallet
//
//  Created by harish on 07/04/2014.
//  Copyright (c) 2014 Narendra. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController
@synthesize webView=_webView;
@synthesize urlString=_urlString;

+(PreviewViewController *)initViewControllerUrl:(NSString *)url{
    PreviewViewController * preview =[[PreviewViewController alloc]initWithNibName:@"PreviewViewController" bundle:[NSBundle mainBundle]];
    preview.title = @"Preview";
    preview.urlString = url;
    return preview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    // Do any additional setup after loading the view from its nib.
}
-(void)doneBarButtonClicked{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authenticated);
    
    if (!_authenticated) {
        _authenticated = NO;
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:[NSURL URLWithString:_urlString] delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    
    return YES;
}


#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated = YES;
    [_webView loadRequest:[NSURL URLWithString:_urlString]];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
   [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [[ActivityIndicator currentIndicator]displayActivity:@"Loading..."];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[ActivityIndicator currentIndicator]displayCompleted];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompletedWithError:@"Fail."];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
