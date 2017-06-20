//
//  UIViewController+FastAlert.h
//  sj
//
//  Created by SJG on 16/11/7.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SJFAActionCallBack)(UIAlertAction *action);
typedef void (^SJFATextFiedConfig)(UITextField *textField);
typedef void (^SJFAPresentComplete)();

@interface UIViewController (FastAlert)


/**
 弹框提示信息

 @param message 提示内容
 @return 控制器本身
 */
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message;


/**
 弹框提示信息
 
 @param message 提示内容
 @param callBack 点击确定的回调
 @return 控制器本身
 */
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message
                               actionCallBack:(SJFAActionCallBack)callBack;


/**
 会自动消失的弹框提示

 @param message 提示信息
 @return  弹框提示本身
 */
- (UIAlertController *)sj_fa_alertWithDismissMessage:(NSString *)message;



/**
 双选项弹框提示

 @param message          消息内容
 @param cancelTitle     取消按钮标题
 @param cancelCallBack  取消按钮回调
 @param confirmTitle    确定按钮标题
 @param confirmCallBack 确定按钮回调
 @return                控制器本身
 */
- (UIAlertController *)sj_fa_alertWithMessage:(NSString *)message
                                  cancelTitle:(NSString *)cancelTitle
                               cancelCallBack:(SJFAActionCallBack)cancelCallBack
                                 confirmTitle:(NSString *)confirmTitle
                              confirmCallBack:(SJFAActionCallBack)confirmCallBack;





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
                                 completion:(SJFAPresentComplete)complete;



- (UIAlertController *)sj_fa_actionSheet;

@end

