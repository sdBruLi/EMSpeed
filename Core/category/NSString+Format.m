//
//  NSString+format.m
//  EMStock
//
//  Created by flora on 14-6-24.
//
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (NSString *)em_stringWithFlowLength:(int)flowLen
{
    NSString *des = @"Bytes";
    double _size = (double)flowLen;
    //    //转化未kb
    //    if(_size > 1024)
    //    {
    _size = _size / 1024.0;
    des = @"KB";
    //    }
    //转化为M
    if(_size > 1024)
    {
        _size = _size / 1024.0;
        des = @"MB";
    }
    //    //转换为G
    //    if(_size > 1024)
    //    {
    //        _size = _size / 1024.0;
    //        des = @"G";
    //    }
    //
    //    //转换为T
    //    if(_size > 1024)
    //    {
    //        _size = _size / 1024.0;
    //        des = @"T";
    //    }
    return[NSString stringWithFormat:@"%.2f%@",_size,des];
    
}



- (NSString *)em_phoneNumberDescription
{
    if (self.length > 7)
    {
        return [NSString stringWithFormat:@"%@-%@-%@",[self substringToIndex:3],
                [self substringWithRange:NSMakeRange(3, self.length - 7)],
                [self substringFromIndex:self.length-4]];
    }
    else
    {
        return self;
    }
}

@end
