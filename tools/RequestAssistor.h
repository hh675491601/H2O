//
//  RequestAssistor.h
//  GamePlatform
//
//  Created by hehao on 15/9/2.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

@interface RequestAssistor : NSObject
+(void)requestWithDetailCompleteBlock:(void(^)(BaseClass *requestDic))block;
+(void)requestWith:(int)sender UpPullDetailCompleteBlock:(void(^)(BaseClass *requestDic))block;
@end
