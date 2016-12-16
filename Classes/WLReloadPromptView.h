//
//  WLReloadPromptView.h
//  ZHWAYNE
//
//  Created by Wayne on 15/12/23.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WLReloadPromptViewDelegate;
@protocol WLReloadPromptViewDataSource;
@class WLReloadPromptView;




@protocol WLReloadPromptViewDelegate <NSObject>

@required
- (BOOL)reloadPromptViewAllowedReload;

@optional
- (void)didTapedReloadButtonInReloadPromptView:(WLReloadPromptView *)reloadView;

@end

@protocol WLReloadPromptViewDataSource <NSObject>

@optional
- (UIImage *)imageInReloadPromptView:(WLReloadPromptView *)promptView;
- (NSAttributedString *)descriptionInReloadPromptView:(WLReloadPromptView *)promptView;
- (UIControl *)buttonInReloadPromptView:(WLReloadPromptView *)promptView;



@end


@interface WLReloadPromptView : UIView

- (instancetype)initWithViewController:(UIViewController <WLReloadPromptViewDelegate, WLReloadPromptViewDataSource>*)viewController;
- (instancetype)initWithViewController:(UIViewController *)viewController delegate:(id<WLReloadPromptViewDelegate>)delegate dataSource:(id<WLReloadPromptViewDataSource>)dataSource;

- (void)appear;
- (void)disappear;
- (void)update; // 重新调用代理方法，更新内容

NS_ASSUME_NONNULL_END

@end
