//
//  EMHTTPResponse.m
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "EMHTTPResponse.h"

@implementation EMHTTPResponse


+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject {
    
    if (![EMHTTPResponse isStandardResponse:responseObject]) {
        return nil;
    }
    
    EMHTTPResponse *response = [[EMHTTPResponse alloc] init];
    response.status = [responseObject[@"status"] integerValue];
    response.updateTime = [[self updateTimeFormatter] dateFromString:responseObject[@"updatetime"]];
    response.responseData = responseObject[@"data"];
    
    return response;
}


+ (BOOL)isStandardResponse:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]
        && responseObject[@"status"]
        && responseObject[@"updatetime"]
        && responseObject[@"data"])
    {
        return YES;
    }
    
    return NO;
}


+ (NSDateFormatter *)updateTimeFormatter {
    static NSDateFormatter *_dateFormatter = nil;
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return _dateFormatter;
}

@end
