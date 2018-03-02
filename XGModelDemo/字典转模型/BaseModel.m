//
//  BaseModel.m
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import "BaseModel.h"
#import <objc/message.h>

@implementation BaseModel

// KVC将字典转换成实体
- (instancetype)initWithDic:(NSDictionary*)dic{
    
    // 获取当前类名
    NSString* className = NSStringFromClass([self class]);
    // 创建对象po
    Class class = NSClassFromString(className);
    self = [[class alloc]init];
    
    if (![dic isEqual:[NSNull null]]) {
        // 利用 KVC 来批量设置key value
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// KVC赋值找不到Key出错的处理方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    // 现在支持id属性了，所以不需要这样处理了
//    if ([key isEqualToString:@"id"]) {
//  // 重新指向到一个自定义的属性
//        self.userId = value;
//    }
}

@end
