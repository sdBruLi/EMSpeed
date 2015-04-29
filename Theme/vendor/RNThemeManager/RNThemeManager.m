//
//  RNThemeManager.m
//  DT Kit
//
//  Created by Ryan Nystrom on 12/2/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNThemeManager.h"
#import "UIColor+HexString.h"
#import "RNThemeManager.h"

NSString * const RNThemeManagerDidChangeThemes = @"RNThemeManagerDidChangeThemes";

@interface RNThemeManager ()

@property (nonatomic, strong, readwrite) NSString *currentThemeName;

@end

@implementation RNThemeManager

#pragma mark - Singleton

+ (instancetype)sharedManager {
    static RNThemeManager *_sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTheme = [[self alloc] init];
    });
    
    return _sharedTheme;
}

- (NSString *)bundleIdenfiter:(NSString *)name
{
    static NSString *idString = nil;
    
    if (idString == nil)
    {
        CFStringRef identifier = CFBundleGetIdentifier(CFBundleGetMainBundle());
        idString = (__bridge NSString *)identifier;
        idString = [[NSString alloc] initWithFormat:@"%@.%@",idString,name];
    }
    return idString;
}

- (instancetype)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:[self bundleIdenfiter:@"defaulttheme"]];
        if (! themeName) {
            themeName = @"default";
        }
        
        [self changeTheme:themeName];
    }
    return self;
}

#pragma mark - Setters

- (void)setStyles:(NSDictionary *)styles {
    BOOL isFirst = _styles == nil;
    _styles = styles;
    if (! isFirst) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RNThemeManagerDidChangeThemes object:nil];
    }
}

- (void)setCurrentThemeName:(NSString *)currentThemeName {
    _currentThemeName = currentThemeName;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentThemeName forKey:[self bundleIdenfiter:@"defaulttheme"]];
    [defaults synchronize];
}

#pragma mark - Actions

- (void)changeTheme:(NSString *)themeName {
    if ([themeName isEqualToString:self.currentThemeName]) {
        return;
    }
    
    self.currentThemeName = themeName;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.currentThemeName ofType:@"plist"];
    NSDictionary *styles = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // if our theme inherits from another, merge
    if (styles[@"INHERITED_THEME"] != nil) {
        styles = [self inheritedThemeWithParentTheme:styles[@"INHERITED_THEME"] childTheme:styles];
    }
    
    
    styles = [self parseDictionaryKeysWithSytles:styles];
    
    self.styles = styles;
}

// 去掉一层dictionary key
- (NSDictionary *)parseDictionaryKeysWithSytles:(NSDictionary *)styles
{
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [mdict addEntriesFromDictionary:obj];
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            [mdict setObject:obj forKey:key];
        }
    }
    
    NSMutableDictionary *dictKeys = [NSMutableDictionary dictionary];
    NSMutableArray *conflictKeys = [NSMutableArray array];
    
    
#ifdef DEBUG
    
    // 计算重复的key
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            for (NSString *akey in obj) {
                if ([dictKeys objectForKey:akey]) {
                    [conflictKeys addObject:akey];
                }
                
                [dictKeys setObject:obj forKey:akey];
            }
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            if ([dictKeys objectForKey:key]) {
                [conflictKeys addObject:key];
            }
            [dictKeys setObject:obj forKey:key];
        }
    }
    
    if ([conflictKeys count]>0) {
        NSLog(@"重复的颜色 KEY = %@", conflictKeys);
        assert(0);
    }
    
    
#endif
    
    return [NSDictionary dictionaryWithDictionary:mdict];
}



- (NSDictionary *)inheritedThemeWithParentTheme:(NSString *)parentThemeName childTheme:(NSDictionary *)childTheme {
    NSString *path = [[NSBundle mainBundle] pathForResource:parentThemeName ofType:@"plist"];
    NSMutableDictionary *parent = [[NSDictionary dictionaryWithContentsOfFile:path] mutableCopy];
    
    // merge child into parent overriding parent values
    [childTheme enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        parent[key] = obj;
    }];
    
    return parent;
}

#pragma mark - Constants

#pragma mark - Fonts

- (UIFont *)fontForKey:(NSString*)key {
    NSString *sizeKey = [key stringByAppendingString:@"Size"];
    
    NSString *fontName = self.styles[key];
    NSString *size = self.styles[sizeKey];
    
    while (self.styles[fontName]) {
        fontName = self.styles[fontName];
    }
    
    while (self.styles[size]) {
        size = self.styles[size];
    }
    
    if (fontName && size) {
        if ([fontName isEqualToString:@"bold"])
        {
        return [UIFont boldSystemFontOfSize:size.floatValue];
        }
        else
        {
            return [UIFont fontWithName:fontName size:size.floatValue];
        }
    }
    else if (size)
    {
        return [UIFont systemFontOfSize:size.floatValue];
    }
    return nil;
}

#pragma mark - Colors

- (UIColor *)colorForKey:(NSString *)key {
    NSString *hexString = self.styles[key];
    
    while (self.styles[hexString]) {
        hexString = self.styles[hexString];
    }
    
    if (hexString) {
        return [UIColor em_colorWithHexString:hexString];
    }
    return nil;
}

#pragma mark - Images

- (UIImage *)imageForKey:(NSString *)key {
    NSString *imageName = self.styles[key];
    
    while (self.styles[imageName]) {
        imageName = self.styles[imageName];
    }
    
    if (imageName) {
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

@end
