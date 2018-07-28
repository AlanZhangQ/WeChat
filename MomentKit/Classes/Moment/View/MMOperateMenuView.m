//
//  MMOperateMenuView.m
//  MomentKit
//
//  Created by Alan on 2018/07/15.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "MMOperateMenuView.h"
#import <UUButton.h>

@interface MMOperateMenuView ()

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *menuBtn;

@end

@implementation MMOperateMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.menuBtn];
        [self addSubview:self.menuView];
        
        _show = NO;
        self.menuView.width = 0;
        self.menuView.left = kOperateWidth-kOperateBtWidth;
    }
    return self;
}

#pragma mark - UI
- (UIButton *)menuBtn
{
    if (!_menuBtn) {
        _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(kOperateWidth-kOperateBtWidth, 0, kOperateBtWidth, kOperateHeight)];
        [_menuBtn setImage:[UIImage imageNamed:@"moment_operate"] forState:UIControlStateNormal];
        [_menuBtn setImage:[UIImage imageNamed:@"moment_operate_hl"] forState:UIControlStateHighlighted];
        [_menuBtn addTarget:self action:@selector(menuClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}

- (UIView *)menuView
{
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kOperateWidth-kOperateBtWidth, kOperateHeight)];
        _menuView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:74.0/255.0 blue:75.0/255.0 alpha:1.0];
        _menuView.layer.cornerRadius = 4.0;
        _menuView.layer.masksToBounds = YES;
        
        [self setupUI];
    }
    return _menuView;
}

- (void)setupUI
{
    // 赞
    UUButton *likeBtn = [[UUButton alloc] initWithFrame:CGRectMake(0, 0, _menuView.width/2, kOperateHeight)];
    likeBtn.backgroundColor = [UIColor clearColor];
    likeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    likeBtn.spacing = 3;
    [likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    [likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"moment_like"] forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:likeBtn];
    
    // 赞
    UUButton *commentBtn = [[UUButton alloc] initWithFrame:CGRectMake(likeBtn.right, 0, likeBtn.width, kOperateHeight)];
    commentBtn.backgroundColor = [UIColor clearColor];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    likeBtn.spacing = 3;
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"moment_comment"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:commentBtn];
    
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(likeBtn.right-5, 8, 0.5, kOperateHeight-16)];
    line.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    [_menuView addSubview:line];
}

#pragma mark - 显示/不显示
- (void)setShow:(BOOL)show
{
    _show = show;
    CGFloat menu_left = kOperateWidth-kOperateBtWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = kOperateWidth-kOperateBtWidth;
    }
    self.menuView.width = menu_width;
    self.menuView.left = menu_left;
}

#pragma mark - 事件
- (void)menuClick
{
    _show = !_show;
    CGFloat menu_left = kOperateWidth-kOperateBtWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = kOperateWidth-kOperateBtWidth;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.width = menu_width;
        self.menuView.left = menu_left;
    }];
}

- (void)likeClick
{
    if (self.likeMoment) {
        self.likeMoment();
    }
}

- (void)commentClick
{
    if (self.commentMoment) {
        self.commentMoment();
    }
}

@end

