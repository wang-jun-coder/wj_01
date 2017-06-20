//
//  SJGWKWebHelper.h
//  sj
//
//  Created by SJG on 16/12/30.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@class SJGWKWebHelper;
typedef void(^SJGWKWebHelperCallBack)(SJGWKWebHelper *helper, id data);

@interface SJGWKWebHelper : NSObject
<WKScriptMessageHandler>

+ (instancetype)helperWithWkWebView:(WKWebView *)wkweb;
- (instancetype)initWithtWKWebView:(WKWebView *)wkweb;

// 弱引用初始化的 wkweb
@property (nonatomic, weak, readonly) WKWebView *wkweb;
// JS --> mobile 事件统一回调
@property (nonatomic, copy)SJGWKWebHelperCallBack JSCallMobile;


/**
 是否忽略全局事件, 默认不忽略
 */
@property (nonatomic, assign) BOOL ignoreGlobalJs;

/**
 没有对应可响应的 js 方法
 */
- (void)noResponseForJs;

@end
