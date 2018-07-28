//
//  Comment.h
//  MomentKit
//
//  Created by Alan on 2018/07/12.
//  Copyright © 2018年 Alan. All rights reserved.
//
//  评论Model
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

// 正文
@property (nonatomic,copy) NSString *text;
// 发布者名字
@property (nonatomic,copy) NSString *userName;
// 发布时间戳
@property (nonatomic,assign) long long time;
// 关联动态的PK
@property (nonatomic,assign) int pk;

@end
