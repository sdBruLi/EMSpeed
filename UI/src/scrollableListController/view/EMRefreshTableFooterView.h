//
//  EMRefreshTableFooterView.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-14.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMRefreshTableHeaderView.h"
#import "EMRefreshTableHeaderViewForSubclass.h"


@class EMRefreshTableFooterView;
@protocol EMRefreshTableFooterViewDelegate
- (void)emRefreshTableFooterDidTriggerRefresh:(EMRefreshTableFooterView*)view;
- (BOOL)emRefreshTableFooterDataSourceIsLoading:(EMRefreshTableFooterView*)view;
@optional
- (NSDate*)emRefreshTableFooterDataSourceLastUpdated:(EMRefreshTableFooterView*)view;
@end


@interface EMRefreshTableFooterView : EMRefreshTableHeaderView {
    
}

@property (nonatomic, assign) id delegate;

@end