//
//  UIBarButtonItem+EM.m
//  EMStock
//
//  Created by xoHome on 14-11-4.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation EMBarButtonItem

- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    if (EMOSVersion() >= 7.0)
    {
        self = [super initWithImage:image style:style target:target action:action];
        if (self) {
            self.tintColor = RGB(0x46, 0x90, 0xef);
            
        }
        return self;
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 40, 30);
        //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
#ifdef DEBUGCOLOR
        button.backgroundColor = [UIColor redColor];
#endif
        id item = [[UIBarButtonItem alloc] initWithCustomView:button];
        return item;
    }
}

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    if (EMOSVersion() >= 7.0)
    {
        self = [super initWithTitle:title style:style target:target action:action];
        if (self) {
            self.tintColor = RGB(0x46, 0x90, 0xef);
        }
        return self;
    }
    else
    {
        UIButton* button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:RGB(0x46, 0x90, 0xef) forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        button.frame = CGRectMake(0, 0, 60, 30);
#ifdef DEBUGCOLOR
        button.backgroundColor = [UIColor redColor];
#endif
        return [self initWithCustomView:button];
    }
}
#pragma clang diagnostic pop

@end


@implementation UIBarButtonItem(Custom)

+ (NSArray *)em_rightItemsWithImage1:(UIImage *)image1 target1:(id)target1 action1:(SEL)action1
                           image2:(UIImage *)image2 target2:(id)target2 action2:(SEL)action2
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image1 forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    CGSize itemSize = CGSizeMake(28, EMNavigationBarHeight()-8);
    button.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [button addTarget:target1 action:action1 forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *item2 =[[EMBarButtonItem alloc] initWithImage:image2
                                                             style:UIBarButtonItemStylePlain
                                                            target:target2 action:action2];
    
#ifdef DEBUGCOLOR
    button.backgroundColor = [UIColor redColor];
#endif
    if (EMOSVersion() >= 7.0)
    {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    return [NSArray arrayWithObjects:item2,item1,nil];
}

@end



