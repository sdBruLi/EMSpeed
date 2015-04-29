//
//  EMTextStatusBar.m
//  YCStock
//
//  Created by meiosis chen on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EMStatusBarWindow.h"

const CGFloat kStatusBarAnimationDuration = .3f;
const CGFloat kStatusBarAnimationDelay = .5f;

static EMStatusBarWindow *__sharedStatusBarWindow;

@interface EMStatusBarWindow()
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, retain) UIView<EMStatusBarUpdating> *statusBar0;
@property (nonatomic, retain) UIView<EMStatusBarUpdating> *statusBar1;
@end


@implementation EMStatusBarWindow
@synthesize array = _array;
@synthesize isAnimating = _isAnimating;
@synthesize statusBar0 = _statusBar0;
@synthesize statusBar1 = _statusBar1;


+ (EMStatusBarWindow *)sharedManager
{
    @synchronized(self) {
        if (__sharedStatusBarWindow == nil) {
            __sharedStatusBarWindow = [[EMStatusBarWindow alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
        }
    }
    
    return __sharedStatusBarWindow;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.clipsToBounds = YES;
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.array = [NSMutableArray array];
        self.isAutoHidden = YES;
        _isSwaped = NO;
    }
    return self;
}

+ (void)showStatusBarWithModel:(id<EMStatusBarModel>)data
{
    [self hiddenStatusBarAnimated:NO];
    [[EMStatusBarWindow sharedManager].array addObject:data];
    [[EMStatusBarWindow sharedManager] showStartStatusBar];
}

+ (void)showStatusBarWithData:(id<EMStatusBarModel>)data
                  autoDismiss:(BOOL)autoDismiss
{
    [self hiddenStatusBarAnimated:NO];
    [[EMStatusBarWindow sharedManager].array addObject:data];
    [[EMStatusBarWindow sharedManager] showStartStatusBar];
}

+ (void)showStatusBarWithArray:(NSArray *)array
{
    [self hiddenStatusBarAnimated:NO];
    [[EMStatusBarWindow sharedManager].array addObjectsFromArray:array];
    [[EMStatusBarWindow sharedManager] showStartStatusBar];
}

+ (void)hiddenStatusBarAnimated:(BOOL)animated
{
    if (animated) {
        [EMStatusBarWindow sharedManager].alpha = 1.f;
        [UIView animateWithDuration:kStatusBarAnimationDuration animations:^{
            [EMStatusBarWindow sharedManager].alpha = 0.f;
        } completion:^(BOOL finished) {
            if (finished) {
                [EMStatusBarWindow sharedManager].hidden = YES;
                [[EMStatusBarWindow sharedManager].array removeAllObjects];
                for (UIView *view in [EMStatusBarWindow sharedManager].subviews) {
                    [view removeFromSuperview];
                }
                [EMStatusBarWindow sharedManager].statusBar0 = nil;
                [EMStatusBarWindow sharedManager].statusBar1 = nil;
                [EMStatusBarWindow sharedManager].isAnimating = NO;
            }
        }];
    }
    else{
        [EMStatusBarWindow sharedManager].hidden = YES;
        [[EMStatusBarWindow sharedManager].array removeAllObjects];
        for (UIView *view in [EMStatusBarWindow sharedManager].subviews) {
            [view removeFromSuperview];
        }
        [EMStatusBarWindow sharedManager].statusBar0 = nil;
        [EMStatusBarWindow sharedManager].statusBar1 = nil;
        [EMStatusBarWindow sharedManager].isAnimating = NO;
    }
}

- (UIView<EMStatusBarUpdating> *)currentStatusBar
{
    return _isSwaped ? _statusBar1 : _statusBar0;
}

- (UIView<EMStatusBarUpdating> *)nextStatusBar
{
    return _isSwaped ? _statusBar0 : _statusBar1;
}

- (BOOL)hasNext
{
    if ([[EMStatusBarWindow sharedManager].array count] > 0) {
        return YES;
    }
    
    return NO;
}

- (void)showStartStatusBar
{
    if (![self hasNext] || _isAnimating) {
        return;
    }
    
    [EMStatusBarWindow sharedManager].hidden = NO;
    [EMStatusBarWindow sharedManager].alpha = 1.f;
    
    if ([[EMStatusBarWindow sharedManager].array count] > 0) {
        id<EMStatusBarModel> data = [[EMStatusBarWindow sharedManager].array objectAtIndex:0];
        UIView<EMStatusBarUpdating> *view = [data statusBarWithData:data];
        if (_isSwaped) {
            _statusBar1 = view;
        }
        else {
            _statusBar0 = view;
        }
        [view updateStatusBar:data];
        [self addSubview:view];
    }
    
    if ([[EMStatusBarWindow sharedManager].array count] > 1) {
        id<EMStatusBarModel> data = [[EMStatusBarWindow sharedManager].array objectAtIndex:1];
        UIView<EMStatusBarUpdating> *view = [data statusBarWithData:data];
        if (_isSwaped) {
            _statusBar0 = view;
        }
        else {
            _statusBar1 = view;
        }
        [view updateStatusBar:data];
        [self addSubview:view];
    }
    
    if ([[EMStatusBarWindow sharedManager].array count] == 1) {
        [self playSingleAnimation];
    }
    else {
        [self playMultiStartAnimation];
    }
}

- (void)showNextStatusBar
{
    if (![self hasNext] || _isAnimating) {
        return;
    }
    
    [EMStatusBarWindow sharedManager].hidden = NO;
    [EMStatusBarWindow sharedManager].alpha = 1.f;
    
    if ([[EMStatusBarWindow sharedManager].array count] > 1) {
        id<EMStatusBarModel> data = [[EMStatusBarWindow sharedManager].array objectAtIndex:1];
        UIView<EMStatusBarUpdating> *view = [data statusBarWithData:data];
        if (_statusBar0 == nil) {
            _statusBar0 = view;
        }
        else if (_statusBar1 == nil){
            _statusBar1 = view;
        }
        [view updateStatusBar:data];
        [self addSubview:view];
    }
    
    if ([[EMStatusBarWindow sharedManager].array count] == 1) {
        [self playMultiEndAnimation];
    }
    else {
        [self playMultiNextAnimation];
    }
}

- (void)playSingleAnimation
{
    if (_isAnimating) {
        return;
    }
    
    _isAnimating = YES;
    
    UIView *currentView = _statusBar0 ? _statusBar0 : _statusBar1;
    
    currentView.frame = [self currentStatusBarDesFrame];
    
    currentView.alpha = 0.f;
    [UIView animateWithDuration:kStatusBarAnimationDuration animations:^{
        currentView.alpha = 1.f;
        currentView.frame = [self currentStatusBarDesFrame];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.isAutoHidden) {
                currentView.alpha = 1.f;
                [UIView animateWithDuration:kStatusBarAnimationDuration
                                      delay:kStatusBarAnimationDelay
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                    currentView.alpha = 0.f;
                } completion:^(BOOL finished) {
                    if (finished) {
                        // 出列
                        [[EMStatusBarWindow sharedManager].array removeAllObjects];
                        [currentView removeFromSuperview];
                        _statusBar0 = nil;
                        _statusBar1 = nil;
                        
                        _isAnimating = NO;
                    }
                }];
            }
        }
    }];
}


- (void)playMultiStartAnimation
{
    UIView *currentView = [self currentStatusBar];
    UIView *nextView = [self nextStatusBar];
    
    currentView.frame = [self currentStatusBarOriginFrame];
    nextView.frame = [self nextStatusBarOriginFrame];
    [UIView animateWithDuration:kStatusBarAnimationDuration
                     animations:^{
        currentView.frame = [self currentStatusBarDesFrame];
        nextView.frame = [self nextStatusBarDesFrame];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:kStatusBarAnimationDuration
                                  delay:kStatusBarAnimationDelay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 currentView.frame = [self dismissStatusBarDesFrame];
                                 nextView.frame = [self currentStatusBarDesFrame];
                                 
                             } completion:^(BOOL finished) {
                                 if (finished) {
                                     // 出列
                                     if([[EMStatusBarWindow sharedManager].array count] > 0) {
                                         [[EMStatusBarWindow sharedManager].array removeObjectAtIndex:0];
                                     }
                                     
                                     if (_statusBar0.frame.origin.y == [self dismissStatusBarDesFrame].origin.y) {
                                         [_statusBar0 removeFromSuperview];
                                         _statusBar0 = nil;
                                     }
                                     else if (_statusBar1.frame.origin.y == [self dismissStatusBarDesFrame].origin.y) {
                                         [_statusBar1 removeFromSuperview];
                                         _statusBar1 = nil;
                                     }
                                     
                                     _isSwaped = !_isSwaped;
                                     _isAnimating = NO;
                                     
                                     if ([self hasNext]) {
                                         [self showNextStatusBar];
                                     }
                                 }
                             }];
        }
    }];
}

- (void)playMultiNextAnimation
{
    UIView *currentView = [self currentStatusBar];
    UIView *nextView = [self nextStatusBar];
        
    currentView.frame = [self currentStatusBarDesFrame];
    nextView.frame = [self currentStatusBarOriginFrame];
    [UIView animateWithDuration:kStatusBarAnimationDuration
                          delay:kStatusBarAnimationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         currentView.frame = [self dismissStatusBarDesFrame];
                         nextView.frame = [self currentStatusBarDesFrame];
                         
                     } completion:^(BOOL finished) {
                         if (finished) {
                             // 出列
                             if([[EMStatusBarWindow sharedManager].array count] > 0) {
                                 [[EMStatusBarWindow sharedManager].array removeObjectAtIndex:0];
                             }
                             
                             if (_statusBar0.frame.origin.y == [self dismissStatusBarDesFrame].origin.y) {
                                 [_statusBar0 removeFromSuperview];
                                 _statusBar0 = nil;
                             }
                             else if (_statusBar1.frame.origin.y == [self dismissStatusBarDesFrame].origin.y) {
                                 [_statusBar1 removeFromSuperview];
                                 _statusBar1 = nil;
                             }
                             
                             _isSwaped = !_isSwaped;
                             _isAnimating = NO;
                             
                             if ([self hasNext]) {
                                 [self showNextStatusBar];
                             }
                         }
                     }];
}

- (void)playMultiEndAnimation
{
    UIView *currentView = _statusBar0 ? _statusBar0 : _statusBar1;
    
    currentView.frame = [self currentStatusBarDesFrame];
    
    [UIView animateWithDuration:kStatusBarAnimationDuration
                     animations:^{
        currentView.frame = [self currentStatusBarDesFrame];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!self.isAutoHidden && [[EMStatusBarWindow sharedManager].array count] == 1) {
                // 不是自动隐藏 且只有自己一个
                // 那就一直显示着
            }
            else{
                currentView.alpha = 1.f;
                [UIView animateWithDuration:kStatusBarAnimationDuration
                                      delay:kStatusBarAnimationDelay
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                    
                    currentView.alpha = 0.f;
                    
                } completion:^(BOOL finished) {
                    if (finished) {
                        // 出列
                        if([[EMStatusBarWindow sharedManager].array count] > 0) {
                            [[EMStatusBarWindow sharedManager].array removeObjectAtIndex:0];
                        }
                        
                        [currentView removeFromSuperview];
                        if (_statusBar0) {
                            _statusBar0 = nil;
                        }
                        if (_statusBar1) {
                            _statusBar1 = nil;
                        }
                        
                        _isAnimating = NO;
                        
                        // 虽然是播放最后的动画, 如果在动画期间又添加新的model, 则继续播放
                        if ([self hasNext]) {
                            [self showNextStatusBar];
                        }
                    }
                }];
            }
        }
    }];
}

# pragma mark - frames

- (CGRect)currentStatusBarOriginFrame
{
    return CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (CGRect)nextStatusBarOriginFrame
{
    return CGRectMake(0, self.frame.size.height * 2, self.frame.size.width, self.frame.size.height);
}

- (CGRect)currentStatusBarDesFrame
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (CGRect)nextStatusBarDesFrame
{
    return CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (CGRect)dismissStatusBarDesFrame
{
    return CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

@end
