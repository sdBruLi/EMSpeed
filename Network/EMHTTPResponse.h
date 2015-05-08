//
//  EMHTTPResponse.h
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMHTTPResponse : NSObject {
    
}

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, strong) id responseData; // dictionary or array
@property (nonatomic, strong) NSError *error;

+ (instancetype)responseWithObject:(id)object;

@end
