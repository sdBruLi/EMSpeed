//
//  EMArtPopupView.h
//
//  Created by Samuel Chen on 2014.12.17
//

#import <UIKit/UIKit.h>

/**
 箭头方向
 */
typedef NS_ENUM(NSInteger, EMArtPopupViewArrowDirection) {
    EMArtPopupViewArrowDirectionNone, // 未知
    EMArtPopupViewArrowDirectionUp,
    EMArtPopupViewArrowDirectionDown,
    EMArtPopupViewArrowDirectionLeft,
    EMArtPopupViewArrowDirectionRight,
    
} ;

@class EMArtPopupView;
@class EMArtPopupContentView;
@class EMArtPopupOverlay;

/**
 *  弹框委托
 */
@protocol EMArtPopupViewDelegate <NSObject>
@optional

/**
 *  点击事件委托
 *
 *  @param popupView 弹框界面
 *  @param sender    事件传递的控件
 */
- (void)EMArtPopView:(EMArtPopupView *)popupView didPressAction:(id)sender; // 点击事件


/**
 *  界面消失事件委托
 *
 *  @param popupView 弹框界面
 */
- (void)EMArtPopupViewDidDismissed:(EMArtPopupView *)popupView;
@end



/**
 *  这是一个弹框控件, 具体方向箭头和透明背景的功能, 
 *  具体显示的弹框界面可以有用户自己实现(content view)
 */
@interface EMArtPopupView : UIView {
    
    /**
     *  箭头方向
     */
    EMArtPopupViewArrowDirection    _arrowDirection;
    
    /**
     *  箭头位置
     */
    CGFloat                         _arrowPosition;
    
    /**
     *  箭头尺寸
     */
    CGFloat                         _kArrowSize;
}


/**
 *  具体显示的弹框内容视图
 */
@property (nonatomic, readonly, strong) UIView *contentView;


/**
 *  一层透明的覆盖view
 */
@property (nonatomic, readonly, strong) EMArtPopupOverlay *overlayView;


/**
 *  父view, 即内容贴在那个view上
 */
@property (nonatomic, readonly, weak) UIView *parentView;


/**
 *  转屏时, 默认会消失
 */
@property (nonatomic, assign) BOOL dismissWhenDeviceRotation;


/**
 *  进入后台时, 默认会消失
 */
@property (nonatomic, assign) BOOL dismissWhenEnterBackground;


/**
 *  圆角
 */
@property (nonatomic, assign) float cornerRound;


/**
 *  背景填充颜色, 默认为白色
 */
@property (nonatomic, strong) UIColor *fillBGColor;


/**
 *  边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;


/**
 *  会传递给 content view的actionDelegate
 */
@property (nonatomic, weak) id<EMArtPopupViewDelegate> actionDelegate;


/**
 *  单例
 *
 *  @return EMArtPopupView单例
 */
+ (EMArtPopupView *)sharedArtPopView;

// 如有点击事件, contentView需要实现EMArtPopupViewAction协议

/**
 *  显示弹框
 *
 *  @param contentView 弹框的内容视图
 *  @param parentView  弹框在哪个视图之上
 *  @param rect        位置
 *  @param delegate    委托
 *
 *  @return 弹框实例
 */
+ (EMArtPopupView *)showContent:(EMArtPopupContentView *)contentView
                         inView:(UIView *)parentView
                       fromRect:(CGRect)rect
                       delegate:(id<EMArtPopupViewDelegate>)delegate;

/**
 *  弹框消失
 *
 *  @param animated 是否动画
 */
+ (void)dismiss:(BOOL)animated;

@end


/**
 *  弹框内容的视图
 */
@interface EMArtPopupContentView : UIView

/**
 *  点击事件委托
 */
@property (nonatomic, weak) id<EMArtPopupViewDelegate> actionDelegate;
@end



/**
 *  用作覆盖的半透明的view
 */
@interface EMArtPopupOverlay : UIView

/**
 *  背景颜色, 默认黑色 alpha 0.25f
 */
@property (nonatomic, strong) UIColor *backgroundColor; // default: black alpha 0.25
@end




