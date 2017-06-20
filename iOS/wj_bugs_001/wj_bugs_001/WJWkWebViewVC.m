//
//  SJGWKActivityVC.m
//  sj
//
//  Created by SJG on 2017/6/19.
//  Copyright © 2017年 jack liu. All rights reserved.
//

#import "WJWkWebViewVC.h"
#import "UIViewController+SJGWKWebView.h"
#import "SJGWKWebHelper.h"


@interface WJWkWebViewVC ()
@property (nonatomic, strong) SJGWKWebHelper *helper;

@end

@implementation WJWkWebViewVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initialize
{
    
    NSString *url = @"http://lab.wangjuncoder.cn:3001/bugs/bugs_001.html";
//    NSString *url = @"http://lab.wangjuncoder.cn:3001/fixs/fixs_001.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // setup wkwebview
    [self sj_setupWkwebViewComplete:^(WKWebView *wkweb) {
        self.helper = [SJGWKWebHelper helperWithWkWebView:wkweb];
        wkweb.frame = self.view.bounds;
        __weak WJWkWebViewVC *weakSelf = self;
        self.helper.JSCallMobile = ^(SJGWKWebHelper *helper, id data) {
            NSString *funcName = [data valueForKey:@"funcName"];
            
            if([funcName isEqualToString:@"shareClick"]){
                [weakSelf js_shareClick:data];
            } else {
                // 没有可处理方法, 提示错误
                [helper noResponseForJs];
            };
        };
        
        [wkweb loadRequest:request];
        // KVO 监听 wkwebView 加载进度
        [wkweb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }];

    
    __weak WJWkWebViewVC *weakSelf = self;
    self.sj_wk_endLoading = ^(id data, NSString *errMsg) {
      
        if (errMsg) return ;
        
        // wk 兼容 webView 约定方法
        NSString *js = [NSString stringWithFormat:@"window.JSCallMobile = {};window.JSCallMobile.shareClick = function(param){var para = {funcName:\"shareClick\", title:param.title,content:param.content,thumb:param.thumb,url:param.url};window.webkit.messageHandlers.JSCallMobile.postMessage(para);};window.JSCallMobile.js_getUserInfo = function(param){return %@;}", [weakSelf js_getUserInfo]];
        [weakSelf.sj_wkweb evaluateJavaScript:js
                            completionHandler:nil];
    };
    
}


- (void)dealloc
{
    [self.sj_wkweb.configuration.userContentController removeScriptMessageHandlerForName:@"JSCallMobile"];
    [self.sj_wkweb removeObserver:self forKeyPath:@"title"];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.title = [change valueForKey:NSKeyValueChangeNewKey];
    }
}


#pragma mark - actions

- (void)js_shareClick:(NSDictionary *)param
{
    NSString *url = [param objectForKey:@"url"];
    NSString *thumb = [param objectForKey:@"thumb"];
    NSString *title = [param objectForKey:@"title"];
    NSString *content = [param objectForKey:@"content"];
    
    NSLog(@"js_shareWithParam: -- %@ -- %@ -- %@ -- %@ -- %@", url, thumb, title, content, [NSThread currentThread]);
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (NSString *)js_getUserInfo
{
    return @"{\"userId\":998,\"userName\":\"呵呵哒\"}";
}



@end
