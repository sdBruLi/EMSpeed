//
//  EMCheckBoxControl.m
//  UI
//
//  Created by Samuel on 15/4/7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMCheckBoxControl.h"
#import "EMContext.h"

@implementation EMCheckBoxControl

- (instancetype)initWithTitle:(NSString *)title
     checkBoxTitles:(NSArray *)titleArray
{
    return [[EMCheckBoxControl alloc] initWithTitle:title radioTitles:titleArray];
}

-(instancetype)initWithTitles:(NSArray *)titleArray
{
    return [[EMCheckBoxControl alloc] initWithTitles:titleArray];
}

-(void)radioBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    long index = btn.tag - kRadioButtonTag;
    _selectedIndex = index;
    
    if (_selectedIndex>=0) {
        NSNumber *number = [_isSelectedRadios objectAtIndex:_selectedIndex];
        BOOL flag = [number boolValue];
        flag = !flag;
        [_isSelectedRadios replaceObjectAtIndex:_selectedIndex withObject:[NSNumber numberWithBool:flag]];
        
        EMCheckBox *checkBox = [_radios objectAtIndex:_selectedIndex];
        checkBox.isSelected = flag;
        
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(radioControl:didClickRadio:)])
            [self.delegate radioControl:self didClickRadio:sender];
    }
}

- (Class)radioClass
{
    return [EMCheckBox class];
}

- (void)setCheckBox:(BOOL)isOn atIndex:(int)index
{
    if (index >=0 && index < [_radios count]) {
        EMCheckBox *checkBox = [_radios objectAtIndex:index];
        checkBox.isSelected = isOn;
        [_isSelectedRadios replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:isOn]];
    }
}

@end


@implementation EMCheckBox

+ (EMCheckBox *)checkBoxWithTitle:(NSString *)title
                          onImage:(UIImage *)onImage
                         offImage:(UIImage *)offImage
                           target:(id)target
                           action:(SEL)selector
{
    EMCheckBox *checkBox = [EMCheckBox buttonWithType:UIButtonTypeCustom];
    checkBox.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [checkBox setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [checkBox setTitle:title forState:UIControlStateNormal];
    [checkBox setImage:offImage forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:13];
    [checkBox addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    checkBox.onImage = onImage ? onImage : [EMCheckBox defaultOnImage];
    checkBox.offImage = offImage ? offImage : [EMCheckBox defaultOffImage];
    checkBox.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    checkBox.frame = CGRectMake(0, 0, 50, 20);
    return checkBox;
}

+ (EMCheckBox *)radioWithTitle:(NSString *)title
                    onImage:(UIImage *)onImage
                   offImage:(UIImage *)offImage
                     target:(id)target
                     action:(SEL)selector
{
    return [EMCheckBox checkBoxWithTitle:title onImage:onImage offImage:offImage target:target action:selector];
}

+ (EMCheckBox *)radioWithTitle:(NSString *)title
                     target:(id)target
                     action:(SEL)selector
{
    return [EMCheckBox checkBoxWithTitle:title target:target action:selector];
}


+ (EMCheckBox *)checkBoxWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)selector
{
    return [EMCheckBox checkBoxWithTitle:title onImage:nil offImage:nil target:target action:selector];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
}

+ (UIImage *)defaultOnImage
{
    return [UIImage imageNamed:EMUIResName(@"checkbox_on")];
}

+ (UIImage *)defaultOffImage
{
    return [UIImage imageNamed:EMUIResName(@"checkbox_off")];
}

@end