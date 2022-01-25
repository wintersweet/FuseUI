//
//  FUWebViewController.m
//  FUSEPRO
//
//  Created by tancheng on 2019/4/9.
//  Copyright © 2019 FUSENANO. All rights reserved.
//

#import "FUWebViewController.h"

static NSString * const wkWebViewEstimatedProgressKey = @"estimatedProgress";

@interface FUWebViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKWebViewConfiguration *webConfig;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation FUWebViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat height = CGRectGetHeight(self.view.bounds) - [self navHieght];
    self.webView.frame = CGRectMake(0, [self navHieght], CGRectGetWidth(self.view.bounds), height);
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:wkWebViewEstimatedProgressKey];
}

#pragma mark - UI

- (void)setupUI {
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.progressView];
    self.progressView.hidden = true;
}

- (CGFloat)navHieght {
    CGFloat height = 44;
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    return height + statusHeight;
}

- (CGFloat)toolBarHeight {
    CGFloat height = 49;
    CGFloat safeBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return height + safeBottom;
}

- (void)reloadToolBar {
    
}

#pragma mark - WKUIDelegate
///alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    completionHandler();
}
///confirm
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    completionHandler(true);
}
///text
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    completionHandler(defaultText);
}

#pragma mark - WKNavigationDelegate
//start load
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = false;
    [self reloadToolBar];
}
//load finish
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = true;
    self.navigationItem.title =  self.customTitle ? self.customTitle : webView.title;
    [self reloadToolBar];
}
// load error
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = true;
}

#pragma mark - kvo progress

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:wkWebViewEstimatedProgressKey]) {
        float progress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.progressView setProgress:progress animated:true];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.webConfig];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:wkWebViewEstimatedProgressKey options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (WKWebViewConfiguration *)webConfig {
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc] init];
        if (self.userContentController) {
            _webConfig.userContentController = self.userContentController;
        }
    }
    return _webConfig;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    }
    return _progressView;
}

@end
