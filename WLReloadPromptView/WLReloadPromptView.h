//
//  WLReloadPromptView.h
//  ZHWAYNE
//
//  Created by Wayne on 15/12/23.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface WLReloadPromptView : UIView

@property (strong, nonatomic) IBInspectable UIColor *ringColor;
@property (strong, nonatomic) IBInspectable UIColor *WIFIColor;
@property (strong, nonatomic) IBInspectable UIColor *promptTextColor;
@property (strong, nonatomic) IBInspectable UIColor *reloadTitleColor;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@property (strong, nonatomic) IBInspectable UIColor *borderFillColor;
@property (copy, nonatomic) IBInspectable NSString *promptText;
@property (copy, nonatomic) IBInspectable NSString *reloadTitle;
@property (assign, nonatomic) IBInspectable CGFloat borderRadius;

@property (nullable, copy, nonatomic) void (^reloadActions)(void);

- (instancetype)initWithCoveredView:(UIView *)view;
- (instancetype)initWithCoveredView:(UIView *)view reloadActions:(void (^ _Nullable)(void))actions;
- (instancetype)initWithFrame:(CGRect)frame NS_DEPRECATED_IOS(2_0, 2_0);
- (instancetype)init NS_DEPRECATED_IOS(2_0, 2_0);

- (void)appear;
- (void)disappear;

NS_ASSUME_NONNULL_END

@end
