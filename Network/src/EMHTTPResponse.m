//
//  EMHTTPResponse.m
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "EMHTTPResponse.h"

@implementation EMHTTPResponse


+ (instancetype)responseWithObject:(id)object
{
    if ([EMHTTPResponse isEMStandardResponse:object]) {
        return [EMHTTPResponse responseWithResponse:object];
    }
    else {
        return [EMHTTPResponse responseWithResponseObject:object];
    }
    
    return nil;
}


+ (instancetype)responseWithResponseObject:(NSDictionary *)responseObject {
    EMHTTPResponse *response = [[EMHTTPResponse alloc] init];
    response.responseData = responseObject;
    
    return response;
}


+ (instancetype)responseWithResponse:(NSDictionary *)responseObject {
    EMHTTPResponse *response = [[EMHTTPResponse alloc] init];
    response.status = [responseObject[@"status"] integerValue];
    response.updateTime = [[self updateTimeFormatter] dateFromString:responseObject[@"updatetime"]];
    response.responseData = responseObject[@"data"];
    
    return response;
}



+ (BOOL)isEMStandardResponse:(id)responseObject
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
