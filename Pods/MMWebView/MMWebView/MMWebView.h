//
//  MMWebView.h
//  MMWebView
//
//  Created by Alan on 2017/5/22.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol MMWebViewDelegate;
@interface MMWebView : WKWebView <WKNavigationDelegate>

// 代理
@property (nonatomic,assign) id<MMWebViewDelegate> delegate;
// 是否显示进度条[默认 NO]
@property (nonatomic,assign) BOOL displayProgressBar;
// displayProgressBar为YES是可用
@property(nonatomic, strong) UIColor *progressTintColor;
// displayProgressBar为YES是可用
@property(nonatomic, strong) UIColor *trackTintColor;

/*
 缓存类型，这里清除所有缓存
 
 WKWebsiteDataTypeDiskCache,
 WKWebsiteDataTypeOfflineWebApplicationCache,
 WKWebsiteDataTypeMemoryCache,
 WKWebsiteDataTypeLocalStorage,
 WKWebsiteDataTypeCookies,
 WKWebsiteDataTypeSessionStorage,
 WKWebsiteDataTypeIndexedDBDatabases,
 WKWebsiteDataTypeWebSQLDatabases
 */

// 清缓存
- (void)clearCache;

@end

@protocol MMWebViewDelegate <NSObject>

@optional
// 网页加载进度
- (void)webView:(MMWebView *)webView estimatedProgress:(CGFloat)progress;
// 网页标题更新
- (void)webView:(MMWebView *)webView didUpdateTitle:(NSString *)title;
// 网页开始加载
- (BOOL)webView:(MMWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;
// 网页开始加载
- (void)webViewDidStartLoad:(MMWebView *)webView;
// 网页完成加载
- (void)webViewDidFinishLoad:(MMWebView *)webView;
// 网页加载出错
- (void)webView:(MMWebView *)webView didFailLoadWithError:(NSError *)error;

@end
