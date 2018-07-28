//
//  MLLabelUtil.h
//  MomentKit
//
//  Created by Alan on 2018/07/13.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MLLabel/MLLinkLabel.h>
#import "Moment.h"
#import "Comment.h"

@interface MLLabelUtil : NSObject

// 获取linkLabel
MLLinkLabel *kMLLinkLabel();
// 获取富文本
NSMutableAttributedString *kMLLinkLabelAttributedText(id object);

@end
