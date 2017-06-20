//
//  NSObject+NilCheck.m
//  sj
//
//  Created by SJG on 16/11/8.
//  Copyright © 2016年 jack liu. All rights reserved.
//

#import "NSObject+NilCheck.h"

@implementation NSObject (NilCheck)

+ (BOOL)wj_nc_isObjectNil:(id)obj
{
    if (obj == nil) return YES;
    if (obj == [NSNull null]) return YES;
    return NO;
}

@end
