//
//  EMButtonTableViewCell.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMMenuTableViewCell.h"
#import "EMMenuItem.h"
#import "EMThemeManager.h"

@implementation EMMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self applyTheme];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)update:(id<MMCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[EMMenuItem class]]) {
        EMMenuItem *aitem = cellModel;
        self.buttonTitleLabel.text = aitem.title;
    }
}


- (void)applyTheme{
    if ([EMThemeManager themeType] == EMAPPThemeTypeLight) {
        self.backgroundColor = [UIColor whiteColor];
        self.buttonTitleLabel.textColor = [UIColor blackColor];
    }
    else if ([EMThemeManager themeType] == EMAPPThemeTypeBlack) {
        self.backgroundColor = [UIColor blackColor];
        self.buttonTitleLabel.textColor = [UIColor whiteColor];
    }
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        [self registerThemeChangeNotificaiton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
    }
    return self;
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
