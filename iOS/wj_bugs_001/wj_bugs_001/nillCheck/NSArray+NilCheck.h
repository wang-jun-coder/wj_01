//
//  NSArray+NilCheck.h
//  sj
//
//  Created by SJG on 16/11/8.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NilCheck)

/**
 判断数组是否为空

 @param array 待测数据
 @return 测试结果, yes 为空, no 不为空
 */
+ (BOOL)wj_nc_isArrayNil:(NSArray *)array;

@end
