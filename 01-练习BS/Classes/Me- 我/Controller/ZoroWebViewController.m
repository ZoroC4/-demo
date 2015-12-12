//
//  ZoroWebViewController.m
//  01-练习BS
//
//  Created by grylls on 15/11/18.
//  Copyright © 2015年 grylls. All rights reserved.
//

#import "ZoroWebViewController.h"

@interface ZoroWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation ZoroWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)reload{

    [self.webView reload];
}

- (IBAction)back{
    [self.webView goBack];
}
- (IBAction)forward{
    [self.webView goForward];
}

#pragma mark -- <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

@end
