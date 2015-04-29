//
//  NSObject+ymreflect.m
//  blStock
//
//  Created by flora on 13-12-9.
//
//

#import "NSObject+Reflect.h"
#import <objc/runtime.h>

@implementation NSObject (Reflect)

- (NSArray*)propertyKeys
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

- (BOOL)em_reflectDataFromOtherObject:(NSObject*)dataSource
{
    BOOL ret = NO;
    NSArray *keys = [self propertyKeys];
    for (NSString *key in keys) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:key];
            }
        }
    }
    return ret;
}

- (BOOL)em_reflectDataFromOtherDictionary:(NSDictionary*)dataSource
{
    BOOL ret = NO;
    
    NSArray *keys = [self propertyKeys];
    NSArray *sourcekeys = [dataSource allKeys];
    
    for (NSString *key in sourcekeys)
    {
        NSString *pKey = [keys em_containCaseInsensitiveString:[self replaceSpecialKey:key]];
        ret = (pKey && pKey.length) ? YES : NO;
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:pKey];
            }
        }
    }
    return ret;
}

- (BOOL)em_reflectDataRecursionFromOtherDictionary:(NSDictionary*)dataSource
{
    BOOL ret = NO;
    id keysObject = self;
    
    while (![keysObject isMemberOfClass:[NSObject class]])
    {
        NSArray *keys = [keysObject propertyKeys];
        NSArray *sourcekeys = [dataSource allKeys];
        
        for (NSString *key in sourcekeys)
        {
            NSString *pKey = [keys em_containCaseInsensitiveString:[self replaceSpecialKey:key]];
            ret = (pKey && pKey.length) ? YES : NO;
            if (ret) {
                id propertyValue = [dataSource valueForKey:key];
                //该值不为NSNULL，并且也不为nil
                if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                    [self setValue:propertyValue forKey:pKey];
                }
            }
        }
        keysObject = [[[keysObject superclass] alloc] init];
    }
    return ret;
    
}

//处理异常的key
- (NSString *)replaceSpecialKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        return @"Id";
    }
    
    if ([key isEqualToString:@"description"])
    {
        return @"emdescription";
    }
    return key;
}

- (BOOL)em_setField:(NSArray *)field list:(NSArray *)list
{
    BOOL ret = NO;
    for (int i = 0; i < [field count]; i++)
    {
        NSString *key   = [self  replaceSpecialKey:[field objectAtIndex:i]];
        id value = [list objectAtIndex:i];

        if ([value isKindOfClass:[NSNull class]]  == NO &&
            value != nil &&
            [self respondsToSelector:NSSelectorFromString(key)])
        {
            [self setValue:value forKey:key];
            ret = YES;
        }
    }
    return ret;
}

@end


@implementation NSArray(caseInsensitiveCompare)

- (NSString *)em_containCaseInsensitiveString:(NSString *)string
{
    NSString *result = nil;
    BOOL contain = NO;
    for (NSString *object in self)
    {
        if ([object caseInsensitiveCompare:string] == NSOrderedSame)
        {
            contain = YES;
            result = object;
            break;
        }
        
    }
    return result;
}

@end