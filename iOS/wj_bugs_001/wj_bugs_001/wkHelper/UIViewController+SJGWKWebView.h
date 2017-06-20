//
//  UIViewController+SJGWKWebView.h
//  sj
//
//  Created by SJG on 16/12/31.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "UIViewController+FastAlert.h"

typedef void(^SJGWKWebViewCallback)(id data, NSString *errMsg);

@interface UIViewController (SJGWKWebView)

// 给 UIViewController 扩展一个控件
@property (nonatomic, strong, readonly) WKWebView *sj_wkweb;

// 开始加载回调
@property (nonatomic, copy)SJGWKWebViewCallback sj_wk_beginLoading;
// 加载结束回调
@property (nonatomic, copy)SJGWKWebViewCallback sj_wk_endLoading;



/**
  如需使用, 初始化 wkwebview

 @param block 初始化完毕, 追加操作
 */
- (void)sj_setupWkwebViewComplete:(void(^)(WKWebView *wkweb))block;

@end
