//
//  SJGWKWebHelper.m
//  sj
//
//  Created by SJG on 16/12/30.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "SJGWKWebHelper.h"

@interface SJGWKWebHelper ()
@property (nonatomic, weak, readwrite) WKWebView *wkWeb;
@end

@implementation SJGWKWebHelper
+ (instancetype)helperWithWkWebView:(WKWebView *)wkweb
{
    return [[self alloc] initWithtWKWebView:wkweb];
}
- (instancetype)initWithtWKWebView:(WKWebView *)wkweb
{
    if (self = [super init]) {
        self.wkWeb = wkweb;
        [wkweb.configuration.userContentController addScriptMessageHandler:self name:@"JSCallMobile"];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@: dealloc", self);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    // 全局事件预处理
    if (!self.ignoreGlobalJs) {
        // 全局事件预处理成功, 直接返回不再向下传递
        if ([self globalJsActionProcess:message.body]) return;
    }
    if (self.JSCallMobile) self.JSCallMobile(self, message.body);
}

#pragma mark - public

/**
 没有对应可响应的 js 方法
 */
- (void)noResponseForJs
{
    // 没有可处理方法, 提示错误
    NSString *js = @"jsCallMobileErr();";
    [self.wkWeb evaluateJavaScript:js completionHandler:nil];
}


#pragma mark - gloable js actions

/**
 全局 js 事件处理

 @param data js 请求数据
 @return 是否处理成功, 若为 yes 则处理成功, 否则未处理
 */
- (BOOL)globalJsActionProcess:(NSDictionary *)data
{
    NSString *funcName = [data objectForKey:@"funcName"];
    
    // 全局用户印刷品预览事件
    if ([funcName isEqualToString:@"globalJSActionDemo1"]) {
        
    }
    
    return NO;
}

#pragma mark js actions
- (BOOL)globalJSActionDemo1:(NSDictionary *)data
{
    NSLog(@"globalJSActionDemo1");
    return NO;
}


#pragma mark - private

/**
 获取 wkweb 所在 view 对应的控制器

 @return 对应的控制器
 */
- (UIViewController *)getWkWebViewSuperController
{
    UIResponder *rp = self.wkWeb.nextResponder;
    while (rp && ![rp isKindOfClass:[UIViewController class]]) {
        rp = rp.nextResponder;
    }
    if (![rp isKindOfClass:[UIViewController class]]) {
        rp = nil;
    }
    return (UIViewController *)rp;
}


@end
