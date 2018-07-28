//
//  MMImagePreviewView.h
//  MomentKit
//
//  Created by Alan on 2018/07/14.
//  Copyright © 2018年 Alan. All rights reserved.
//
//  朋友圈动态>>图片预览视图
//

#import <UIKit/UIKit.h>

//### 点击预览时的承载视图
@interface MMImagePreviewView : UIView <UIScrollViewDelegate>

// 横向滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
// 页码指示
@property (nonatomic,strong) UIPageControl *pageControl;
// 页码数目
@property (nonatomic,assign) NSInteger pageNum;
// 页码索引
@property (nonatomic,assign) NSInteger pageIndex;

@end

//### 单个大图显示视图
@interface MMScrollView : UIScrollView <UIScrollViewDelegate>

// 显示的大图
@property (nonatomic,strong) UIImageView *imageView;
// 原始Frame
@property (nonatomic,assign) CGRect originRect;
// 过程Frame
@property (nonatomic,assign) CGRect contentRect;
// 图片
@property (nonatomic,strong) UIImage *image;
// 点击大图(关闭预览)
@property (nonatomic, copy) void (^tapBigView)(MMScrollView *scrollView);
// 长按大图
@property (nonatomic, copy) void (^longPressBigView)(MMScrollView *scrollView);

// 更新Frame
- (void)updateOriginRect;

@end
