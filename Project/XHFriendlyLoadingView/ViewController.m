//
//  ViewController.m
//  XHFriendlyLoadingView
//
//  Created by 曾 宪华 on 13-12-31.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "ViewController.h"
#import "XHFriendlyLoadingView.h"

@interface ViewController () {
    NSInteger selectedCount; // default is 1
}

@property (nonatomic, strong) XHFriendlyLoadingView *friendlyLoadingView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoading];
}

- (void)showLoading {
    [self.friendlyLoadingView showFriendlyLoadingViewWithText:@"正在加载..." loadingAnimated:YES];
    
    double delayInSeconds = 3.0;
    __weak typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        selectedCount ++;
        if (selectedCount == 3) {
            [weakSelf.friendlyLoadingView showFriendlyLoadingViewWithText:@"重新加载失败，请返回检查网络。" loadingAnimated:NO];
        } else {
            [weakSelf.friendlyLoadingView showReloadViewWithText:@"加载失败，请点击刷新按钮重新加载。"];
        }
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _friendlyLoadingView = [[XHFriendlyLoadingView alloc] initWithFrame:self.view.bounds];
    
    __weak typeof(self) weakSelf = self;
    self.friendlyLoadingView.reloadButtonClickedCompleted = ^(UIButton *sender) {
        // 这里可以做网络重新加载的地方
        
        [weakSelf showLoading];
    };
    [self.view addSubview:self.friendlyLoadingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.friendlyLoadingView = nil;
}

@end
