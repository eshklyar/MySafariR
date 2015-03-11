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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate=self;
    self.webView.scrollView.scrollEnabled = TRUE;
    self.webView.scalesPageToFit = TRUE;

    self.urlTextField.delegate = self;
    [self disableGoForward];
    [self disableGoBack];
//    self.urlTextField.text = @"type url here";
    self.urlTextField.placeholder = @"type url here";
//    self.urlTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.urlTextField.clearButtonMode = UITextFieldViewModeAlways;
//    self.urlTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;

}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"view will Appear");
    //    [self disableGoBack];
    //    [self disableGoForward];
}
#pragma mark - Buttons

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
- (IBAction)onClearButtonPressed:(id)sender {
//    self.urlTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.urlTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;

//    self.urlTextField.text = @"";
//    [self.urlTextField textFieldShouldClear] = YES;
}

- (IBAction)onPreviewButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController new];
    alert.message = @"Comming Soon!";


    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];


}



-(void)disableGoForward {
    if (!self.webView.canGoForward) {
        self.goForwardButton.enabled=NO;
    }
    else{
        self.goForwardButton.enabled=YES;
    }
}
-(void)disableGoBack {
    if (!self.webView.canGoBack) {
        self.goBackButton.enabled =NO;
    }
    else{
        self.goBackButton.enabled=YES;
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
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self disableGoBack];
    [self disableGoForward];
//    NSString *requestPath = [[urlRequest URL] absoluteString];
//    self.urlTextField.text =requestPath;

//    self.urlTextField.text = self.webView.request.description.uppercaseString;
    self.urlTextField.text = self.webView.request.URL.absoluteString;
    self.title = self.webView.request.URL.host;

    if (self.webView.scrollView.tracking) {
        self.urlTextField.hidden = TRUE;
    } else {
         self.urlTextField.hidden = FALSE;
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

@end
