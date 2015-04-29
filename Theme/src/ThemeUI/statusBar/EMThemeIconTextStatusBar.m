//
//  EMIconTextStatusBar.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeIconTextStatusBar.h"
#import "EMThemeStatusBarIconTextModel.h"
#import "EMThemeManager.h"

@implementation EMThemeIconTextStatusBar

- (void)applyTheme{
    if ([EMThemeManager themeType] == EMAPPThemeTypeLight) {
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLabel setTextColor:[UIColor blackColor]];
    }
    else if ([EMThemeManager themeType] == EMAPPThemeTypeBlack) {
        self.backgroundColor = [UIColor blackColor];
        [self.titleLabel setTextColor:[UIColor lightGrayColor]];
    }
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyTheme];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
