//
//  UIViewController+SJGWKWebView.m
//  sj
//
//  Created by SJG on 16/12/31.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "UIViewController+SJGWKWebView.h"
#import <objc/runtime.h>

@interface UIViewController ()
<WKNavigationDelegate, WKUIDelegate>
@end

@implementation UIViewController (SJGWKWebView)

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    NSLog(@"decidePolicyForNavigationAction: \n%@\n%@\n%@", webView, navigationAction, decisionHandler);
    
    NSURL *url = navigationAction.request.URL;
    if ([url.absoluteString hasPrefix:@"tel"] ||
        [url.absoluteString hasPrefix:@"sms"] ||
        [url.absoluteString hasPrefix:@"https://qm.qq.com/cgi-bin/qm/qr"] ||
        [url.absoluteString hasPrefix:@"https://jq.qq.com/"] ||
        [url.absoluteString hasPrefix:@"http://qm.qq.com/cgi-bin/qm/qr"])
    {
        decisionHandler(WKNavigationActionPolicyCancel);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:url];
        });
        NSLog(@"%@", url.absoluteString);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSURL *url = navigationResponse.response.URL;
    if ([url.absoluteString hasPrefix:@"tel"] ||
        [url.absoluteString hasPrefix:@"sms"] ||
        [url.absoluteString hasPrefix:@"https://qm.qq.com/cgi-bin/qm/qr"] ||
        [url.absoluteString hasPrefix:@"https://jq.qq.com/"] ||
        [url.absoluteString hasPrefix:@"http://qm.qq.com/cgi-bin/qm/qr"])
    {
        decisionHandler(WKNavigationResponsePolicyCancel);
        
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:url];
        NSLog(@"%@", url.absoluteString);
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    
}

// 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
//    NSLog(@"didStartProvisionalNavigation: \n%@\n%@\n", webView, navigation);
    if (self.sj_wk_beginLoading) self.sj_wk_beginLoading(nil, nil);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation: \n%@\n%@\n", webView, navigation);
}
// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSString *errMsg = error.localizedDescription ? error.localizedDescription : @"网络连接失败";
    if (self.sj_wk_endLoading) self.sj_wk_endLoading(nil, errMsg);
//    NSLog(@"didFailProvisionalNavigation: \n%@\n%@\n%@", webView, navigation, error);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
//    NSLog(@"didCommitNavigation: \n%@\n%@\n", webView, navigation);
}
// 页面加载结束
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if (self.sj_wk_endLoading) self.sj_wk_endLoading(nil, nil);
//    NSLog(@"didFinishNavigation: \n%@\n%@\n", webView, navigation);
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSString *errMsg = error.localizedDescription ? error.localizedDescription : @"网络连接失败";
    if (self.sj_wk_endLoading) self.sj_wk_endLoading(nil, errMsg);
//    NSLog(@"didFailNavigation: \n%@\n%@\n%@", webView, navigation, error);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition challenge, NSURLCredential * _Nullable credential))completionHandler
{
//    NSLog(@"didReceiveAuthenticationChallenge: \n%@\n%@\n%@\n%@", webView, challenge, challenge, completionHandler);
    // 授权验证
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
//    NSLog(@"webViewWebContentProcessDidTerminate: \n%@", webView);
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
//    NSLog(@"createWebViewWithConfiguration:\n%@\n%@\n%@\n%@", webView, configuration, navigationAction, windowFeatures);
    return webView;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
//    NSLog(@"runJavaScriptAlertPanelWithMessage: \n%@\n%@\n%@\n%@", webView, message, frame, completionHandler);
    [self sj_fa_alertWithMessage:message];
    completionHandler();
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
//    NSLog(@"runJavaScriptConfirmPanelWithMessage: \n%@\n%@\n%@\n%@", webView, message, frame, completionHandler);
    [self sj_fa_alertWithMessage:message
                     cancelTitle:@"取消"
                  cancelCallBack:^(UIAlertAction *action)
     {
         completionHandler(NO);
     }
                    confirmTitle:@"确定"
                 confirmCallBack:^(UIAlertAction *action)
     {
         completionHandler(YES);
     }];

    return;
}


- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
//    NSLog(@"runJavaScriptTextInputPanelWithPrompt: \n%@\n%@\n%@\n%@\n%@", webView, prompt, defaultText, frame, completionHandler);
    __block UIAlertController *alert =  [self sj_fa_alertWithTitle:@"温馨提示"
                                                           message:prompt
                                                       cancelTitle:@"取消"
                                                    cancelCallback:^(UIAlertAction *action)
                                         {completionHandler(nil);}
                                                      confirmTitle:@"确定"
                                                   confirmCallback:^(UIAlertAction *action)
                                         {   UITextField *text = alert.textFields.firstObject;
                                             completionHandler(text.text);}
                                                        otherTitle:nil
                                                     otherCallback:nil
                                                        textField1:^(UITextField *textField)
                                         {textField.placeholder = defaultText;}
                                                        textField2:nil
                                                        completion:nil];
}

#pragma mark - publick method
- (void)sj_setupWkwebViewComplete:(void (^)(WKWebView *))block
{
    
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    conf.userContentController = [[WKUserContentController alloc] init];
    // 支持网页视频播放
    conf.allowsInlineMediaPlayback = YES;
    conf.preferences = [[WKPreferences alloc] init];
    conf.preferences.minimumFontSize = 10;
    conf.preferences.javaScriptEnabled = YES;
    conf.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    

    
    CGRect frame = CGRectMake(0, 0,
                              CGRectGetWidth(self.view.bounds),
                              CGRectGetWidth(self.view.bounds));
    self.sj_wkweb = [[WKWebView alloc] initWithFrame:frame configuration:conf];
    [self.view addSubview:self.sj_wkweb];
    
    self.sj_wkweb.navigationDelegate = self;
    self.sj_wkweb.UIDelegate = self;
    self.sj_wkweb.allowsBackForwardNavigationGestures = NO;
    self.sj_wkweb.contentScaleFactor = [UIScreen mainScreen].scale;
//    self.sj_wkweb.allowsLinkPreview = YES; 9.0 才可使用
    self.sj_wkweb.scrollView.showsVerticalScrollIndicator = NO;
    self.sj_wkweb.scrollView.showsHorizontalScrollIndicator = NO;
    self.sj_wkweb.scrollView.maximumZoomScale = 1;
    self.sj_wkweb.scrollView.minimumZoomScale = 1;
    // 允许侧滑返回
    self.sj_wkweb.allowsBackForwardNavigationGestures = YES;
    
    if (block) block(self.sj_wkweb);
}



#pragma mark - getter && setter
// wk_web
- (WKWebView *)sj_wkweb
{
    return objc_getAssociatedObject(self, @selector(sj_wkweb));
}

- (void)setSj_wkweb:(WKWebView *)sj_wkweb
{
    objc_setAssociatedObject(self, @selector(sj_wkweb), sj_wkweb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// begin loading callback
- (SJGWKWebViewCallback)sj_wk_beginLoading
{
    return objc_getAssociatedObject(self, @selector(sj_wk_beginLoading));
}
- (void)setSj_wk_beginLoading:(SJGWKWebViewCallback)sj_wk_beginLoading
{
    objc_setAssociatedObject(self, @selector(sj_wk_beginLoading), sj_wk_beginLoading, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

// end loading callback
- (SJGWKWebViewCallback)sj_wk_endLoading
{
    return objc_getAssociatedObject(self, @selector(sj_wk_endLoading));
}
- (void)setSj_wk_endLoading:(SJGWKWebViewCallback)sj_wk_endLoading
{
    objc_setAssociatedObject(self, @selector(sj_wk_endLoading), sj_wk_endLoading, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
