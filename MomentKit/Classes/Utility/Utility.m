//
//  Utility.m
//  MomentKit
//
//  Created by Alan on 2018/07/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "Utility.h"

@implementation Utility

#pragma mark - 时间戳转换
+ (NSString *)getDateFormatByTimestamp:(long long)timestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTimestamp = [dat timeIntervalSince1970] ;
    long long int timeDifference = nowTimestamp - timestamp;
    long long int secondTime = timeDifference;
    long long int minuteTime = secondTime/60;
    long long int hoursTime = minuteTime/60;
    long long int dayTime = hoursTime/24;
    long long int monthTime = dayTime/30;
    long long int yearTime = monthTime/12;
    
    if (1 <= yearTime) {
        return [NSString stringWithFormat:@"%lld年前",yearTime];
    }
    else if(1 <= monthTime) {
        return [NSString stringWithFormat:@"%lld月前",monthTime];
    }
    else if(1 <= dayTime) {
        return [NSString stringWithFormat:@"%lld天前",dayTime];
    }
    else if(1 <= hoursTime) {
        return [NSString stringWithFormat:@"%lld小时前",hoursTime];
    }
    else if(1 <= minuteTime) {
        return [NSString stringWithFormat:@"%lld分钟前",minuteTime];
    }
    else if(1 <= secondTime) {
        return [NSString stringWithFormat:@"%lld秒前",secondTime];
    }
    else {
        return @"刚刚";
    }
}

#pragma mark - 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize
{
    CGFloat max_width = kWidth-150;
    CGFloat max_height = kWidth-130;
    CGFloat image_width = singleSize.width;
    CGFloat image_height = singleSize.height;
    
    CGFloat result_width = 0;
    CGFloat result_height = 0;
    if (image_height/image_width > 3.0) {
        result_height = max_height;
        result_width = result_height/2;
    }  else  {
        result_width = max_width;
        result_height = max_width*image_height/image_width;
        if (result_height > max_height) {
            result_height = max_height;
            result_width = max_height*image_width/image_height;
        }
    }
    return CGSizeMake(result_width, result_height);
}


@end
