//
//  NSArray+NilCheck.m
//  sj
//
//  Created by SJG on 16/11/8.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "NSArray+NilCheck.h"
#import "NSObject+NilCheck.h"

@implementation NSArray (NilCheck)

+ (BOOL)wj_nc_isArrayNil:(NSArray *)array
{
    if ([NSObject wj_nc_isObjectNil:array]) return YES;
    if (![array isKindOfClass:[NSArray class]]) return YES;
    if (array.count == 0) return YES;
    return NO;
}


@end
