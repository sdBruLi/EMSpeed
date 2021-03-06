//
//  MMDatasource.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMDataSource.h"
#import <objc/runtime.h>

@implementation MMDataSource
@synthesize sections = _sections;
@synthesize items = _items;

- (instancetype)initWithItems:(NSArray *)aItems sections:(NSArray *)aSections
{
    NSAssert((aItems && aSections && [aItems count]==[aSections count]), nil);
    
    self = [super init];
    if (self) {
        _items = [[[self itemsClass] alloc] initWithArray:aItems];
        _sections = [[[self sectionsClass] alloc] initWithArray:aSections];
    }
    return self;
}

- (Class)sectionsClass
{
    return [NSArray class];
}

- (Class)itemsClass
{
    return [NSArray class];
}


#pragma mark -
#pragma mark Data Source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sections count] ? [_sections count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *cells = [_items objectAtIndex:section];
    return [cells count];
}


/**创建indexpath对应的cell
 *获取对应的cellClass （由子类复写cellClass方法，返回对应生成cell的类型）
 *子类复写此方法时，需要调用配置cell的数据，并且根据cell配置
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> item = [self itemAtIndexPath:indexPath];
    Class class = item.Class;
    
    if (class != NULL)
    {
        NSString* identifier = NSStringFromClass(class);
        id cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
//        if (cell == nil)
//        {
//            if ([identifier length] > 0) {
//                NSString *path = EMPathForBundleResource([NSBundle mainBundle], [NSString stringWithFormat:@"%@.xib", identifier]);
//                BOOL isXibExist = EMIsFileExistAtPath(path);
//                if (isXibExist) {
//                    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil];
//                    if ([cells count] > 0) {
//                        cell= [cells lastObject];
//                    }
//                }
//            }
//        }
        
        if ([cell respondsToSelector:@selector(update:indexPath:)]) {
            [cell update:item indexPath:indexPath];
        }
        else if ([cell respondsToSelector:@selector(update:)]) {
            [cell update:item];
        }
        
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *aCell = cell;
            if ([aCell respondsToSelector:@selector(setLayoutMargins:)]) {
                aCell.layoutMargins = UIEdgeInsetsZero;
                aCell.preservesSuperviewLayoutMargins = NO;
            }
        }
        
        return cell;
    }
    else
    {
        return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([_sections count] > section)
    {
        NSObject *object = [_sections objectAtIndex:section];
        
        if ([object isKindOfClass:[NSString class]])
        {
            return (NSString *)object;
        }
    }
    return nil;
}

# pragma mark - Setter & Getter

- (id<MMCellModel>)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if([_items count] > indexPath.section)
    {
        NSArray *arr = [_items objectAtIndex:indexPath.section];
        if ([arr count] > indexPath.row)
        {
            return [arr objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (id<MMCellModel>)itemAtIndex:(NSUInteger)index
{
    return [self itemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (NSString *)titleAtSection:(NSUInteger)section
{
    assert(section>=0 && section<[_sections count]);
    return [_sections objectAtIndex:section];
}

- (int)sectionIndexWithTitle:(NSString *)title
{
    for (int i=0; i<[_sections count]; i++) {
        NSString *str = [self titleAtSection:i];
        if ([str isEqualToString:title]) {
            return i;
        }
    }
    
    return -1;
}

- (NSArray *)itemsAtSection:(int)section
{
    NSAssert((section>=0 && section<[_sections count]), nil);
    
    return [_items objectAtIndex:section];
}

- (NSArray *)itemsAtSectionWithTitle:(NSString *)title
{
    int section = [self sectionIndexWithTitle:title];
    if (section!=-1) {
        return [self itemsAtSection:section];
    }
    
    return nil;
}

- (NSUInteger)numberOfItemsAtSection:(NSUInteger)section
{
    if (section<[_sections count]) {
        NSArray *items = [_items objectAtIndex:section];
        return [items count];
    }
    
    return 0;
}

- (void)registerCellForView:(UIView *)view
{
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)view;
        
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];// 用作去重复
        
        for (int i=0; i<[_items count]; i++) {
            NSArray *array = [_items objectAtIndex:i];
            for (int j=0; j<[array count]; j++) {
                id<MMCellModel> model = [array objectAtIndex:j];
                NSString *reuseIdentify = model.reuseIdentify;
                Class cls = NSClassFromString(reuseIdentify);
                
                if (![mdict objectForKey:reuseIdentify]) {
                    if (model.isRegisterByClass) {
                        [tableView registerClass:cls forCellReuseIdentifier:reuseIdentify];
                    }
                    else{
                        [tableView registerNib:[UINib nibWithNibName:reuseIdentify bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseIdentify];
                    }
                    
                    [mdict setObject:[NSNumber numberWithBool:YES] forKey:reuseIdentify];
                }
            }
        }
    }
}

@end

