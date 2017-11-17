//
//  ViewController.m
//  XHFriendlyLoadingView
//
//  Created by 曾 宪华 on 13-12-31.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

/**
 * 先把某一项目Fork到自己的github网站上，然后打开Xcode，选择"Clone an existing project"，然后选择那个已经Fork到自己github网站上的项目（不要选择源项目），然后Xcode就会把此项目下载到本地，从而在本地建立一个该项目的本地仓库。对本地仓库里面的代码进行修改，修改完以后利用Xcode上面的"Source Control"里面的"Commit"把修改完的代码提交到本地仓库中，然后利用"Push"把修改完的代码提交到那个已经Fork到自己github网站上的项目所在的自己github网站上的远程仓库中，然后在自己的github网站上点击"Pull requests"进入到新的页面，在新的页面中点击绿色的按钮"New pull request"进入到新的页面，这时就会跳到此项目的源头那里，在这个页面中，github建议项目的原作者把现在修改的版本和原版本进行合并(merge)，在此页面中点击绿色的按钮"Create pull request"，然后写上标题和评论，再点击绿色的按钮"Create pull request"则会正式向项目的原作者提出合并(merge)的请求。
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
