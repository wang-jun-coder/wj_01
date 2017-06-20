//
//  ViewController.m
//  wj_bugs_001
//
//  Created by SJG on 2017/6/19.
//  Copyright © 2017年 SJG. All rights reserved.
//

#import "ViewController.h"
#import "WJWebViewVC.h"
#import "WJWkWebViewVC.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)webViewClick:(UIButton *)sender {
    WJWebViewVC *web = [[WJWebViewVC alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

- (IBAction)wkwebViewClick:(UIButton *)sender {
    WJWkWebViewVC *web = [[WJWkWebViewVC alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

@end
