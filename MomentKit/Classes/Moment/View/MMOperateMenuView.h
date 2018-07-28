//
//  MMOperateMenuView.h
//  MomentKit
//
//  Created by ALan on 2018/07/15.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMOperateMenuView : UIView

@property (nonatomic, assign) BOOL show;

// 赞
@property (nonatomic, copy) void (^likeMoment)();
// 评论
@property (nonatomic, copy) void (^commentMoment)();

@end
