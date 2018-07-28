//
//  Utility.h
//  MomentKit
//
//  Created by Alan on 2018/07/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/**
 时间戳转日期

 @param timestamp 时间戳
 @return 日期
 */
+ (NSString *)getDateFormatByTimestamp:(long long)timestamp;

/**
 获取单张图片的实际size

 @param singleSize 原始
 @return 结果
 */
+ (CGSize)getSingleSize:(CGSize)singleSize;

@end
