//
//  UIViewController+FastAlert.m
//  sj
//
//  Created by SJG on 16/11/7.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "UIViewController+FastAlert.h"
#import "WJNilCheck.h"

static NSString * const FADefaultAlertTitle     = @"温馨提示";
static NSString * const FADefaultAlertSure      = @"确定";
static NSString * const FADefaultAlertContinue  = @"继续";
static NSString * const FADefaultAlertCancel    = @"取消";
static NSString * const FADefaultAlertReset     = @"重置";

@implementation UIViewController (FastAlert)

// 快速提示
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message
{
    return [self sj_fa_alertWithTitle:FADefaultAlertTitle
                              message:message
                          cancelTitle:nil
                       cancelCallback:nil
                         confirmTitle:FADefaultAlertSure
                      confirmCallback:nil
                           otherTitle:nil
                        otherCallback:nil
                           textField1:nil
                           textField2:nil
                           completion:nil];
}

// 带回调的弹框提示
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message
                               actionCallBack:(SJFAActionCallBack)callBack
{
    return [self sj_fa_alertWithTitle:FADefaultAlertTitle
                              message:message
                          cancelTitle:FADefaultAlertSure
                       cancelCallback:callBack
                         confirmTitle:nil
                      confirmCallback:nil
                           otherTitle:nil
                        otherCallback:nil
                           textField1:nil
                           textField2:nil
                           completion:nil];
}


// 自动消失的快速提示
- (UIAlertController *)sj_fa_alertWithDismissMessage:(NSString *)message
{
    UIAlertController *alert = [self sj_fa_alertWithMessage:message];
    [self performSelector:@selector(dismissAlertController:) withObject:alert afterDelay:1.5];
    return alert;
}

// 双选项弹框
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message
                                  cancelTitle:(NSString *)cancelTitle
                               cancelCallBack:(SJFAActionCallBack)cancelCallBack
                                 confirmTitle:(NSString *)confirmTitle
                              confirmCallBack:(SJFAActionCallBack)confirmCallBack
{
    return [self sj_fa_alertWithTitle:FADefaultAlertTitle
                              message:message
                          cancelTitle:cancelTitle
                       cancelCallback:cancelCallBack
                         confirmTitle:confirmTitle
                      confirmCallback:confirmCallBack
                           otherTitle:nil
                        otherCallback:nil
                           textField1:nil
                           textField2:nil
                           completion:nil];
}


/**
 快速弹框基础方法
 
 @param title            弹框标题
 @param message          弹框内荣
 @param cancelTitle      取消标题
 @param cancelCallBack   取消回调
 @param confimTitle      确定标题
 @param confirmCallBack  确定回调
 @param otherTitle       其他标题
 @param otherCallBack    其他回调
 @param textFieldConfig1 文本框配置1
 @param textFieldConfig2 文本框配置2
 @param complete         弹出结束回调
 @return                 弹框控制器
 */
- (UIAlertController *)sj_fa_alertWithTitle:(NSString *)title
                                    message:(NSString *)message
                                cancelTitle:(NSString *)cancelTitle
                             cancelCallback:(SJFAActionCallBack)cancelCallBack
                               confirmTitle:(NSString *)confimTitle
                            confirmCallback:(SJFAActionCallBack)confirmCallBack
                                 otherTitle:(NSString *)otherTitle
                              otherCallback:(SJFAActionCallBack)otherCallBack
                                 textField1:(SJFATextFiedConfig)textFieldConfig1
                                 textField2:(SJFATextFiedConfig)textFieldConfig2
                                 completion:(SJFAPresentComplete)complete
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // 添加取消按钮
    if (![NSString wj_nc_isStringNil:cancelTitle] ||
        ![NSObject wj_nc_isObjectNil:cancelCallBack]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:cancelCallBack];
        [alert addAction:cancel];
        
    }
    // 添加确定按钮
    if (![NSString wj_nc_isStringNil:confimTitle] ||
        ![NSObject wj_nc_isObjectNil:confirmCallBack]) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confimTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:confirmCallBack];
        [alert addAction:confirm];
    }
    
    // 添加其他按钮
    if (![NSString wj_nc_isStringNil:otherTitle] ||
        ![NSObject wj_nc_isObjectNil:otherCallBack]) {
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle
                                                        style:UIAlertActionStyleDefault
                                                      handler:otherCallBack];
        [alert addAction:other];
    }
    
    // 添加文本框1
    if (![NSObject wj_nc_isObjectNil:textFieldConfig1]) {
        [alert addTextFieldWithConfigurationHandler:textFieldConfig1];
    }
    
    // 添加文本框2
    if (![NSObject wj_nc_isObjectNil:textFieldConfig2]) {
        [alert addTextFieldWithConfigurationHandler:textFieldConfig2];
    }
    
    // 弹出框弹出
    [self presentViewController:alert animated:YES completion:complete];
    
    return alert;
}

- (UIAlertController *)sj_fa_actionSheet
{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"actionsheet title"
                                                                       message:@"actionsheed msg"
                                                                preferredStyle: UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"action1 title" style:UIAlertActionStyleDefault
                                                        handler:nil];
    
    
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"action2 title" style:UIAlertActionStyleDefault
                                                        handler:nil];
    
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
    
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:cancel];
    
        [self presentViewController:alert animated:YES completion:nil];
        
        return alert;
}



#pragma mark - private

/**
 消除 alertController

 @param alert  将要被释放的弹框控制器
 */
- (void)dismissAlertController:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}




@end
