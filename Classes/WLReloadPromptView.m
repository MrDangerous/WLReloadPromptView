//
//  WLReloadPromptView.h
//  ZHWAYNE
//
//  Created by Wayne on 15/12/23.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

#import "WLReloadPromptView.h"

char * const setNeedsDisplayContext = "setNeedsDisplay";

@interface WLReloadPromptView ()

@property (nullable, weak, nonatomic) id<WLReloadPromptViewDelegate> rp_delegate;
@property (nullable, weak, nonatomic) id<WLReloadPromptViewDataSource> rp_dataSource;

@property (weak, nonatomic) UIView  *coverdView;  // general is superview
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel  *descriptionLabel;

@end

@implementation WLReloadPromptView

- (instancetype)initWithViewController:(UIViewController<WLReloadPromptViewDelegate,WLReloadPromptViewDataSource> *)viewController {
    return [self initWithViewController:viewController delegate:viewController dataSource:viewController];
}

- (instancetype)initWithViewController:(UIViewController *)viewController delegate:(id<WLReloadPromptViewDelegate>)delegate dataSource:(id<WLReloadPromptViewDataSource>)dataSource {
    if (self = [super initWithFrame:CGRectZero]) {
        _coverdView = viewController.view;
        _rp_delegate = delegate;
        _rp_dataSource = dataSource;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textColor = [UIColor lightGrayColor];
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_descriptionLabel];
    
    [self update];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat contentHeight = 0;
    const CGFloat contentWidth = _coverdView.bounds.size.width * 0.8;
    UIImage *image = nil;
    NSAttributedString *string = nil;
    UIControl *reloadButton = [self viewWithTag:'_btn'];
    if (reloadButton) {
        [reloadButton removeFromSuperview];
        reloadButton = nil;
    }
    
    const CGSize imageSize = CGSizeMake(120, 120);
    CGSize stringSize = CGSizeMake(280, 999);
    
    
    if ([_rp_dataSource respondsToSelector:@selector(imageInReloadPromptView:)]) {
        image = [_rp_dataSource imageInReloadPromptView:self];
    }
    
    
    if ([_rp_dataSource respondsToSelector:@selector(descriptionInReloadPromptView:)]) {
        string = [_rp_dataSource descriptionInReloadPromptView:self];
    }
    
    if ([_rp_dataSource respondsToSelector:@selector(buttonInReloadPromptView:)]) {
        reloadButton = [_rp_dataSource buttonInReloadPromptView:self];
        reloadButton.tag = '_btn';
        [reloadButton addTarget:self action:@selector(reloadbuttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (image) {
        contentHeight += imageSize.height;
    }
    
    if (string) {
        if (image) {
            contentHeight += 40;
        }
        stringSize = [string boundingRectWithSize:stringSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        contentHeight += stringSize.height;
    }
    
    if (reloadButton) {
        if (string) {
            contentHeight += 30;
        }
        contentHeight += reloadButton.bounds.size.height;
    }
    
    CGFloat y = (_coverdView.bounds.size.height - contentHeight) / 2 - 20;
    const CGFloat x = (_coverdView.bounds.size.width - contentWidth) / 2;
    if (image) {
        _imageView.image = image;
        _imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        _imageView.center = CGPointMake(_coverdView.bounds.size.width / 2, y + imageSize.height / 2);
        y += imageSize.height;
    }
    
    if (string) {
        if (image) {
            y += 40;
        }
        _descriptionLabel.attributedText = string;
        _descriptionLabel.frame = CGRectMake(x, y, _coverdView.bounds.size.width - 2 * x, stringSize.height);
        y += _descriptionLabel.frame.size.height;
    }
    
    if (reloadButton) {
        if (string) {
            y += 30;
        }
        reloadButton.frame = CGRectMake(0, y, reloadButton.bounds.size.width, reloadButton.bounds.size.height);
        reloadButton.center = CGPointMake(_coverdView.bounds.size.width / 2, reloadButton.center.y);
        [self addSubview:reloadButton];
    }
}




#pragma mark - Public methods

- (void)appear {
    if (!self.superview) {
        [self.coverdView addSubview:self];
    }
    
    self.hidden = NO;
    self.alpha  = 1;
    [self.superview bringSubviewToFront:self];
    [self update];
}

- (void)disappear {
    if (!self.superview) return;
    
    self.hidden = YES;
    self.alpha  = 0;
    [self.superview insertSubview:self atIndex:0];
    [self update];
}

- (void)update {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.frame = self.superview.bounds;
        [self layoutIfNeeded];
    });
}

#pragma mark - Actions

- (void)reloadbuttonTouchUpInside:(UIControl *)sender {
    if ([_rp_delegate reloadPromptViewAllowedReload] != YES) {
        return;
    }
    
    if ([_rp_delegate respondsToSelector:@selector(didTapedReloadButtonInReloadPromptView:)]) {
        [_rp_delegate didTapedReloadButtonInReloadPromptView:self];
    }
}

#pragma mark - Private methods

//- (UIImage *)drawDefaultImageWithSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);
//    // Drawing code
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // 一个圆
//    CGPoint point = CGPointMake(size.width / 2, size.height / 2);
//    CGRect frame  = convert_points_to_the_rect(point, size.width / 2);
//    
//    CGContextSetLineWidth(ctx, 1);
//    [[UIColor clearColor] setFill];
//    CGContextFillRect(ctx, frame);
//    CGContextAddEllipseInRect(ctx, frame);
//    [[UIColor lightGrayColor] setFill];
//    CGContextFillPath(ctx);
//    
//    // WIFI logo
//    point = CGPointMake(point.x, point.y + 30);
//    UIBezierPath *path;
//    
//    CGContextSetLineWidth(ctx, 6.0);
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    
//    for (int i = 0; i < 4; ++i) {
//        if (i < 3) {
//            path = [UIBezierPath bezierPathWithArcCenter:point radius:60 - i * 20 startAngle:M_PI * 1.24  endAngle:M_PI * 1.76  clockwise:YES];
//            CGContextAddPath(ctx, path.CGPath);
//            CGContextStrokePath(ctx);
//            continue;
//        }
//        
//        path = [UIBezierPath bezierPathWithArcCenter:point radius:2 startAngle:M_PI * 0  endAngle:M_PI * 2  clockwise:YES];
//        CGContextAddPath(ctx, path.CGPath);
//        CGContextStrokePath(ctx);
//    }
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//
//CGRect convert_points_to_the_rect(CGPoint point, CGFloat radius)
//{
//    CGRect rect     = CGRectZero;
//    rect.size.width = rect.size.height = radius * 2;
//    rect.origin.x   = point.x - radius;
//    rect.origin.y   = point.y - radius;
//    
//    return rect;
//}
//
//UIColor* lightColor(UIColor *color, CGFloat value)
//{
//    if (value < -1) value = -1;
//    else if (value > 1) value = 1;
//    else if (value == 0) return color;
//    
//    value = 1 + value;
//    
//    CGFloat h=0,s=0,b=0,a=0;
//    [color getHue:&h saturation:&s brightness:&b alpha:&a];
//    
//    NSDictionary *HSBA = @{@"HSBA-h": @(h),
//                           @"HSBA-s": @(s),
//                           @"HSBA-b": @(b * value),
//                           @"HSBA-a": @(a)};
//    
//    return [UIColor colorWithHue:[HSBA[@"HSBA-h"] doubleValue]
//                      saturation:[HSBA[@"HSBA-s"] doubleValue]
//                      brightness:[HSBA[@"HSBA-b"] doubleValue]
//                           alpha:[HSBA[@"HSBA-a"] doubleValue]];
//}


@end
