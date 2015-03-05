//
//  ViewController.m
//  MySafariR
//
//  Created by Edik Shklyar on 3/2/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()  <UIWebViewDelegate, UITextFieldDelegate>
@property IBOutlet UIWebView *webView;
@property IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;
@property (weak, nonatomic) IBOutlet UIButton *goForwardButton;


@end

@implementation ViewController
- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
     [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate=self;
    self.urlTextField.delegate = self;

}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"view will Appear");
//    [self disableGoBack];
//    [self disableGoForward];
}

-(void)disableGoForward {
    if (!self.webView.canGoBack) {
        self.goForwardButton.enabled=false;
    }
    else{
        self.goForwardButton.enabled=true;
    }
}
-(void)disableGoBack {
    if (!self.webView.canGoBack) {
        self.goBackButton.enabled =false;
    }
    else{
        self.goBackButton.enabled=true;
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSString *urlString = [NSString new];
    urlString = self.urlTextField.text;
    NSLog(@"urlString = %@",urlString);


    NSString *prefix = @"http://";
    if(![urlString hasPrefix:prefix])
    {

        urlString= [prefix stringByAppendingString:urlString];
        NSLog(@"urlString with prefix %@",urlString);
    }

    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@",url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    NSLog(@"urlReq = %@",urlRequest);
    [self.webView loadRequest:urlRequest];
    [self.urlTextField resignFirstResponder];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

//     [self.view addSubview:self.webView];

    return YES;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self disableGoBack];
    [self disableGoForward];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

@end
