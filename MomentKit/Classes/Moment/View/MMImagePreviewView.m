//
//  MMImagePreviewView.m
//  MomentKit
//
//  Created by Alan on 2018/07/14.
//  Copyright © 2018年 ALan. All rights reserved.
//

#import "MMImagePreviewView.h"

#pragma mark - ------------------ 点击预览时的承载视图 ------------------
@implementation MMImagePreviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.userInteractionEnabled = YES;
        // 添加子视图
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        // 页面控制
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.height-40, kWidth, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
    }
    return self;
}

#pragma mark - Setter
- (void)setPageNum:(NSInteger)pageNum
{
    _pageNum = pageNum;
    _pageControl.numberOfPages = pageNum;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageIndex = scrollView.contentOffset.x / self.width;
    _pageControl.currentPage = _pageIndex;
}

@end

#pragma mark - ------------------ 单个大图显示视图 ------------------
@implementation MMScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        self.minimumZoomScale = 1.0;
        self.bouncesZoom = YES;
        self.delegate = self;
        // 显示的图片
        [self addSubview:self.imageView];
        // 双击
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureCallback:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        // 单击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:singleTap];
        // 长按
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureCallback:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

#pragma mark - Getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.contentScaleFactor = [[UIScreen mainScreen] scale];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

#pragma mark - Setter
- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setContentRect:(CGRect)contentRect
{
    _contentRect = contentRect;
    self.imageView.frame = contentRect;
}

#pragma mark - 图片展开
- (void)updateOriginRect
{
    CGSize picSize = self.imageView.image.size;
    if (picSize.width == 0 || picSize.height == 0) {
        return;
    }
    float scaleX = self.frame.size.width/picSize.width;
    float scaleY = self.frame.size.height/picSize.height;
    if (scaleX > scaleY)
    {
        float imgViewWidth = picSize.width*scaleY;
        self.maximumZoomScale = self.frame.size.width/imgViewWidth;
        _originRect = (CGRect){self.frame.size.width/2-imgViewWidth/2,0,imgViewWidth,self.frame.size.height};
    }
    else
    {
        float imgViewHeight = picSize.height*scaleX;
        self.maximumZoomScale = self.frame.size.height/imgViewHeight;
        _originRect = (CGRect){0,self.frame.size.height/2-imgViewHeight/2,self.frame.size.width,imgViewHeight};
        self.zoomScale = 1.0;
    }
    [UIView animateWithDuration:0.4 animations:^{
        self.imageView.frame = _originRect;
    }];
}

#pragma mark - 手势处理
- (void)doubleTapGestureCallback:(UITapGestureRecognizer *)gesture
{
    CGFloat zoomScale = self.zoomScale;
    if (zoomScale == self.maximumZoomScale) {
        zoomScale = 0;
    } else {
        zoomScale = self.maximumZoomScale;
    }
    [UIView animateWithDuration:0.35
                     animations:^{
                         self.zoomScale = zoomScale;
                     }];
}

- (void)singleTapGestureCallback:(UITapGestureRecognizer *)gesture
{
    if (self.tapBigView) {
        self.tapBigView(self);
    }
}

- (void)longPressGestureCallback:(UILongPressGestureRecognizer *)gesture
{
    if (self.longPressBigView) {
        self.longPressBigView(self);
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = self.imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    if (imgFrame.size.width <= boundsSize.width) {
        centerPoint.x = boundsSize.width/2;
    }
    if (imgFrame.size.height <= boundsSize.height) {
        centerPoint.y = boundsSize.height/2;
    }
    self.imageView.center = centerPoint;
}

@end
