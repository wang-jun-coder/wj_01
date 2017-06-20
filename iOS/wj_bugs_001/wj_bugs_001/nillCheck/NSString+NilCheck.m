//
//  NSString+NilCheck.m
//  sj
//
//  Created by SJG on 16/11/8.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "NSString+NilCheck.h"
#import "NSObject+NilCheck.h"
@implementation NSString (NilCheck)
+ (BOOL)wj_nc_isStringNil:(NSString *)str
{
    if([NSObject wj_nc_isObjectNil:str]) return YES;
    // 非本类, 标记为空
//    if (![str isKindOfClass:[NSString class]]) return YES;
    if (![str isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@", str];
    }
    if ([str length] == 0) return YES;
    return NO;
}
@end
