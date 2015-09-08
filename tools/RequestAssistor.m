//
//  RequestAssistor.m
//  GamePlatform
//
//  Created by hehao on 15/9/2.
//  Copyright (c) 2015年 kuaifa. All rights reserved.
//

#import "RequestAssistor.h"
#import "AFNetworking.h"

@implementation RequestAssistor
+(void)requestWithDetailCompleteBlock:(void(^)(BaseClass *requestDic))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:@"http://www.517huwai.com/Mobile/travels?count=10&page=" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject->%@",responseObject);
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
////        NSLog(@"data->%@",jsonData);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
////        NSLog(@"dic->%@",dic);
        BaseClass *BaseDic = [BaseClass modelObjectWithDictionary:responseObject];
        block(BaseDic);
//        NSLog(@"BaseDic->%@",BaseDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

+(void)requestWith:(int)sender UpPullDetailCompleteBlock:(void(^)(BaseClass *requestDic))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"http://www.517huwai.com/Mobile/travels?count=10&page=%d",sender] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject->%@",responseObject);
        BaseClass *BaseDic = [BaseClass modelObjectWithDictionary:responseObject];
        block(BaseDic);
//        NSLog(@"BaseDic->%@",BaseDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
