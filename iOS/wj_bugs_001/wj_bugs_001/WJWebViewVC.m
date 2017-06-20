//
//  SJGActivityVC.m
//  sj
//
//  Created by SJG on 16/9/25.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "WJWebViewVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@protocol WJJSExport <JSExport>

JSExportAs(shareClick, - (void)js_shareClick:(NSDictionary *)param);
- (NSString *)js_getUserInfo;


@end

@interface WJWebViewVC ()
<UIWebViewDelegate, WJJSExport>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;
@end

@implementation WJWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"UIWebView";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
//    NSString *url = @"http://lab.wangjuncoder.cn:3001/bugs/bugs_001.html";
    NSString *url = @"http://lab.wangjuncoder.cn:3001/fixs/fixs_001.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =============== action ===============


#pragma mark =============== getter && setter ===============


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 获取 js 运行环境
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // js 异常捕获
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    // 关联对应 js 方法
    self.context[@"JSCallMobile"] = self;

}

#pragma mark =============== WJJSExport ===============

- (NSString *)js_getUserInfo
{
    return @"{\"userId\":998,\"userName\":\"呵呵哒\"}";
}

/**
 js 调用原生放到

 @param param 方法参数
 */
- (void)js_shareClick:(NSDictionary *)param
{
    NSString *title = [param valueForKey:@"title"];
    NSString *content = [param valueForKey:@"content"];
    NSString *url = [param valueForKey:@"url"];
    NSString *thumb = [param valueForKey:@"thumb"];
 
    NSLog(@"UIWebView ==> js_shareClick: -- %@ -- %@ -- %@ -- %@ -- %@", title, content, url, thumb, [NSThread currentThread]);
    
    // 正确写法
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    });
    
    /**
     // 错误写法, web 若不进行特殊处理则会崩溃(如: http://lab.wangjuncoder.cn:3001/bugs/bugs_001.html)
     UIViewController *vc = [[UIViewController alloc] init];
     vc.view.backgroundColor = [UIColor whiteColor];
     [self.navigationController presentViewController:vc animated:YES completion:nil];
     
     bugs_001.html: 调用崩溃: -[UIKeyboardTaskQueue waitUntilAllTasksAreFinished] may only be called from the main thread.
     
     */
}



@end
