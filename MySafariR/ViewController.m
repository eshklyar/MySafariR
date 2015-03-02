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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate=self;
    self.urlTextField.delegate = self;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSString *urlString = [NSString new];
    urlString = self.urlTextField.text;

    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"url = %@",url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    [self.urlTextField resignFirstResponder];

    return YES;

}

@end
