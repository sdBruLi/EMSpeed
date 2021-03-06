//
//  EMArtPopupView.m
//
//  Created by Samuel Chen on 2014.12.17
//

#import "EMArtPopupView.h"


static EMArtPopupView *__artPopView;


@interface EMArtPopupView() {
    BOOL _isParentViewScrollEnabled;
}

@end


@implementation EMArtPopupView

+ (instancetype)sharedArtPopView
{
    @synchronized(self){
        if (__artPopView==nil) {
            __artPopView = [[EMArtPopupView alloc] init];
        }
    }
    
    return __artPopView;
}

- (instancetype)init
{
    NSAssert(!__artPopView, @"singleton object");
    
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.alpha = 0;
        self.cornerRound = 4.f;
        self.dismissWhenDeviceRotation = YES;
        self.dismissWhenEnterBackground = YES;
        _kArrowSize = 8.f;
        
        self.fillBGColor = [UIColor whiteColor];
        self.borderColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (EMArtPopupView *)showContent:(EMArtPopupContentView *)contentView
                         inView:(UIView *)parentView
                       fromRect:(CGRect)rect
                       delegate:(id<EMArtPopupViewDelegate>)delegate
{
    [[EMArtPopupView sharedArtPopView] showContent:contentView inView:parentView fromRect:rect delegate:delegate];
    return [EMArtPopupView sharedArtPopView];
}

+ (void)dismiss:(BOOL)animated
{
    [[EMArtPopupView sharedArtPopView] dismiss:animated];
}

- (void)showContent:(EMArtPopupContentView *)contentView
             inView:(UIView *)parentView
           fromRect:(CGRect)rect
           delegate:(id<EMArtPopupViewDelegate>)delegate
{
    [self dismiss:NO];
    
    _actionDelegate = delegate;
    _contentView = contentView;
    _parentView = parentView;
    
    if (delegate) {
        contentView.actionDelegate = delegate;
    }
    
    if ([parentView isKindOfClass:[UIScrollView class]]) {
        _isParentViewScrollEnabled = ((UIScrollView *)parentView).scrollEnabled;
        ((UIScrollView *)parentView).scrollEnabled = NO;
    }
    
    [self addSubview:_contentView];
    
    [self setupFrameInView:parentView fromRect:rect];
    
    EMArtPopupOverlay *overlay = [[EMArtPopupOverlay alloc] initWithFrame:parentView.bounds];
    [overlay addSubview:self];
    [parentView addSubview:overlay];
    _overlayView = overlay;
    
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){self.arrowPoint, 1, 1};
    
    self.alpha = 0.f;
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         
                         self.alpha = 1.0f;
                         self.frame = toFrame;
                         
                     } completion:^(BOOL completed) {
                         _contentView.hidden = NO;
                     }];
    [self setNeedsDisplay];
}

- (void)dismiss:(BOOL) animated
{
    if (self.superview) {
        
        if (animated) {
            
            _contentView.hidden = YES;
            const CGRect toFrame = (CGRect){self.arrowPoint, 1, 1};
            
            [UIView animateWithDuration:0.2
                             animations:^(void) {
                                 self.alpha = 0;
                                 self.frame = toFrame;
                                 
                             } completion:^(BOOL finished) {
                                 [self removeSubViews];
                             }];
            
        } else {
            [self removeSubViews];
        }
    }
}

- (void)removeSubViews
{
    [_contentView removeFromSuperview];
    [_overlayView removeFromSuperview];
    [self removeFromSuperview];
    
    if ([_parentView isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)_parentView).scrollEnabled = _isParentViewScrollEnabled;
    }
    _parentView = nil;
    _overlayView = nil;
    __artPopView = nil;
    
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(EMArtPopupViewDidDismissed:)]) {
        [self.actionDelegate EMArtPopupViewDidDismissed:self];
    }
    self.actionDelegate = nil;
}

- (void)setupFrameInView:(UIView *)view
                fromRect:(CGRect)fromRect
{
    const CGSize contentSize = _contentView.frame.size;
    
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    
    const CGFloat rectX0 = fromRect.origin.x;
    const CGFloat rectX1 = fromRect.origin.x + fromRect.size.width;
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    const CGFloat rectYM = fromRect.origin.y + fromRect.size.height * 0.5f;;
    
    const CGFloat widthPlusArrow = contentSize.width + _kArrowSize;
    const CGFloat heightPlusArrow = contentSize.height + _kArrowSize;
    const CGFloat widthHalf = contentSize.width * 0.5f;
    const CGFloat heightHalf = contentSize.height * 0.5f;
    
    const CGFloat kMargin = 5.f;
    
    if (heightPlusArrow < (outerHeight - rectY1)) {
        
        _arrowDirection = EMArtPopupViewArrowDirectionUp;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        //_arrowPosition = MAX(16, MIN(_arrowPosition, contentSize.width - 16));
        _contentView.frame = (CGRect){0, _kArrowSize, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width,
            contentSize.height + _kArrowSize
        };
        
    } else if (heightPlusArrow < rectY0) {
        
        _arrowDirection = EMArtPopupViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + _kArrowSize
        };
        
    } else if (widthPlusArrow < (outerWidth - rectX1)) {
        
        _arrowDirection = EMArtPopupViewArrowDirectionLeft;
        CGPoint point = (CGPoint){
            rectX1,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + kMargin) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){_kArrowSize, 0, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width + _kArrowSize,
            contentSize.height
        };
        
    } else if (widthPlusArrow < rectX0) {
        
        _arrowDirection = EMArtPopupViewArrowDirectionRight;
        CGPoint point = (CGPoint){
            rectX0 - widthPlusArrow,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + 5) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width  + _kArrowSize,
            contentSize.height
        };
        
    } else {
        
        _arrowDirection = EMArtPopupViewArrowDirectionNone;
        
        self.frame = (CGRect) {
            
            (outerWidth - contentSize.width)   * 0.5f,
            (outerHeight - contentSize.height) * 0.5f,
            contentSize,
        };
    }
}

- (CGPoint) arrowPoint
{
    CGPoint point;
    
    if (_arrowDirection == EMArtPopupViewArrowDirectionUp) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMinY(self.frame) };
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionDown) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition, CGRectGetMaxY(self.frame) };
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionLeft) {
        
        point = (CGPoint){ CGRectGetMinX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionRight) {
        
        point = (CGPoint){ CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame) + _arrowPosition  };
        
    } else {
        
        point = self.center;
    }
    
    return point;
}

- (void) drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds
               inContext:UIGraphicsGetCurrentContext()];
}

- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context
{
    CGFloat R0 = 0.267, G0 = 0.303, B0 = 0.335;
    CGFloat R1 = 0.040, G1 = 0.040, B1 = 0.040;
    
    UIColor *tintColor = self.fillBGColor;
    if (tintColor) {
        
        CGFloat a;
        [tintColor getRed:&R0 green:&G0 blue:&B0 alpha:&a];
        [tintColor getRed:&R1 green:&G1 blue:&B1 alpha:&a];
    }
    
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // render arrow
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 0.5f;
    
    if (_arrowDirection == EMArtPopupViewArrowDirectionUp) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - _kArrowSize;
        const CGFloat arrowX1 = arrowXM + _kArrowSize;
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + _kArrowSize + kEmbedFix;
        
        [arrowPath moveToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        
        Y0 += _kArrowSize;
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionDown) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - _kArrowSize;
        const CGFloat arrowX1 = arrowXM + _kArrowSize;
        const CGFloat arrowY0 = Y1 - _kArrowSize - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        
        Y1 -= _kArrowSize;
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionLeft) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X0;
        const CGFloat arrowX1 = X0 + _kArrowSize + kEmbedFix;
        const CGFloat arrowY0 = arrowYM - _kArrowSize;;
        const CGFloat arrowY1 = arrowYM + _kArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        
        X0 += _kArrowSize;
        
    } else if (_arrowDirection == EMArtPopupViewArrowDirectionRight) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X1;
        const CGFloat arrowX1 = X1 - _kArrowSize - kEmbedFix;
        const CGFloat arrowY0 = arrowYM - _kArrowSize;;
        const CGFloat arrowY1 = arrowYM + _kArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R1 green:G1 blue:B1 alpha:1] set];
        
        X1 -= _kArrowSize;
    }
    
    [_borderColor setStroke];
    CGContextSetLineWidth(context, 0.5f);
    
    // render body
    
    const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                          cornerRadius:self.cornerRound];
    
    const CGFloat locations[] = {0, 1};
    const CGFloat components[] = {
        R0, G0, B0, 1,
        R1, G1, B1, 1,
    };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 components,
                                                                 locations,
                                                                 sizeof(locations)/sizeof(locations[0]));
    CGColorSpaceRelease(colorSpace);
    
    CGContextSaveGState(context);
    
    [borderPath addClip];
    
    CGPoint start, end;
    
    if (_arrowDirection == EMArtPopupViewArrowDirectionLeft ||
        _arrowDirection == EMArtPopupViewArrowDirectionRight) {
        
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X1, Y0};
        
    } else {
        
        start = (CGPoint){X0, Y0};
        end = (CGPoint){X0, Y1};
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, 0);
    [borderPath stroke];
    
    CGContextRestoreGState(context);
    
    [arrowPath fill];
    [arrowPath stroke];
    
    CGGradientRelease(gradient);
}

# pragma mark - Notification

- (void)setDismissWhenDeviceRotation:(BOOL)dismissWhenDeviceRotation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
 
    if (dismissWhenDeviceRotation) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationWillChange:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
    }
}

- (void)setDismissWhenEnterBackground:(BOOL)dismissWhenEnterBackground
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    if (dismissWhenEnterBackground) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
}

- (void)orientationWillChange: (NSNotification *) n
{
    [self dismiss:NO];
}

- (void)appDidEnterBackground: (NSNotification *) n
{
    [self dismiss:NO];
}

@end


@implementation EMArtPopupContentView

@end


@interface EMArtPopupOverlay()

@property (nonatomic, strong) UIView *colorOverlayView;

@end


@implementation EMArtPopupOverlay

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.colorOverlayView = [[UIView alloc] initWithFrame:self.bounds];
        self.colorOverlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        self.colorOverlayView.userInteractionEnabled = NO;
        [self addSubview:self.colorOverlayView];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self setOverlayBackgroundColor:backgroundColor];
}

- (void)setOverlayBackgroundColor:(UIColor *)color
{
    self.colorOverlayView.backgroundColor = color;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *touched = [[touches anyObject] view];
    if (touched == self) {
        
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[EMArtPopupView class]]
                && [v respondsToSelector:@selector(dismiss:)]) {
                
                [v performSelector:@selector(dismiss:) withObject:@(YES)];
            }
        }
    }
}

@end
