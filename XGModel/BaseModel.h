//
//  BaseModel.h
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

// KVC将字典转换成实体
- (instancetype)initWithDic:(NSDictionary*)dic;

@end
