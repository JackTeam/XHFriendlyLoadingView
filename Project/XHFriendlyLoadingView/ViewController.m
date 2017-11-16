//
//  ViewController.m
//  XHFriendlyLoadingView
//
//  Created by 曾 宪华 on 13-12-31.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

/**
 * 克隆某一项目在github网站上面的仓库，从而在本地建立一个该项目的本地仓库，然后对本地仓库里面的代码进行修改，修改完以后利用Xcode上面的"Source Control"里面的"Commit"把修改完的代码提交到本地的仓库中，然后利用"Push"把修改完的代码提交到github网站上面的该项目的远程仓库中，然后在github网站上面点击"Pull requests"进入到新的页面，在新的页面中点击绿色的按钮"New pull request"，创建
 */

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
