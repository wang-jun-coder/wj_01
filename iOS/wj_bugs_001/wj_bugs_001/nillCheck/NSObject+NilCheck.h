//
//  NSObject+NilCheck.h
//  sj
//
//  Created by SJG on 16/11/8.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NilCheck)


/**
 判断对象是否为空

 @param obj 待判断对象
 @return 判断结果, yes 为空, NO 不为空
 */
+ (BOOL)wj_nc_isObjectNil:(id)obj;

@end
