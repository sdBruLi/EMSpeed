//
//  EMThemeSrollSegmentedControl.m
//  UIDemo
//
//  Created by Samuel on 15/4/24.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMThemeSrollSegmentedControl.h"
#import "EMThemeSegmentCellFactory.h"

@implementation EMThemeSrollSegmentedControl

- (Class)segmentCellFactoryClass
{
    return [EMThemeSegmentCellFactory class];
}


- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithItems:items];
    if (self) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    
    return self;
}

- (void)applyTheme{
    self.backgroundColor = [UIColor colorForKey:@"common_segmentBgColor"];
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
