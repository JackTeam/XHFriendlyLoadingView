//
//  XHFriendlyLoadingView.h
//  XHFriendlyLoadingView
//
//  Created by 曾 宪华 on 13-12-31.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadButtonClickedCompleted)(UIButton *sender);

@interface XHFriendlyLoadingView : UIView
@property (nonatomic, copy) ReloadButtonClickedCompleted reloadButtonClickedCompleted;

+ (instancetype)shareFriendlyLoadingView;

- (void)showFriendlyLoadingViewWithText:(NSString *)text loadingAnimated:(BOOL)animated;

/**
 * 隐藏页面加载动画及信息提示
 */
- (void)hideLoadingView;

/**
 * 重新加载提示
 * @param reloadString 要显示的提示字符串
 */
- (void)showReloadViewWithText:(NSString *)reloadString;

@end
