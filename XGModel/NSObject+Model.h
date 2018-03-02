//
//  NSObject+Model.h
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

// 根据字典生成属性代码
+ (void)createPropertyWithDic:(NSDictionary*)dic;

// 根据字典生成对象实例
+ (instancetype)instanceWithDic:(NSDictionary*)dic;

@end
