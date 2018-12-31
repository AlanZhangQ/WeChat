//
//  SHTextView.h
//  发布界面（带图片，文字）
//
//  Created by Alan on 16/12/25.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHTextView : UITextView
//提示文字
@property (nonatomic, copy) NSString *placehoder;
//提示文字颜色
@property (nonatomic, strong) UIColor *placehoderColor;

@end
