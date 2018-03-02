//
//  NSObject+Model.m
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)

// 根据字典生成属性代码
+ (void)createPropertyWithDic:(NSDictionary*)dic{
    
    __block NSString* code = @"";
    
    // 遍历字典的Key
    for (NSString* key in dic) {
        
        NSString* modifier;
        NSString* type;
        NSString* propertyName;
        
        propertyName = key;
        id value = dic[key];
        
        if ([value isKindOfClass:[NSString class]]) {
            
            modifier = @"copy";
            type = @"NSString*";
        }else if ([value isKindOfClass:[NSNumber class]]){
            
            modifier = @"assign";
            type = @"NSInteger";
            
            // BOOl也属于NSNumber
            NSString* typeName = NSStringFromClass([value class]);
            if ([typeName isEqualToString:@"__NSCFBoolean"]) {
                type = @"BOOL";
            }
        }else if ([value isKindOfClass:[NSArray class]]){
            
            modifier = @"strong";
            type = @"NSArray*";
        }else if ([value isKindOfClass:[NSDictionary class]]){
            
            modifier = @"strong";
            type = @"NSDictionary*";
        }else{
            
            NSLog(@"无法识别类型 :%@",[value class]);
        }
        
        code = [code stringByAppendingString:[NSString stringWithFormat:@"\n @property (nonatomic,%@)%@ %@; \n",modifier,type,propertyName]];
    }
    
    // 输出代码
    NSLog(@"模型属性:\n %@",code);
}

// 根据字典生成对象实例
+ (instancetype)instanceWithDic:(NSDictionary*)dic{
    
    id _self = [[self alloc]init];
    
    // 获取对象私有属性列表如：_name 这种
    unsigned int count = 0;
    /*
        Ivar*:表示的是指向属性列表数组的第一个属性
        Ivar:表示私有属性
     */
    Ivar* ivarArray = class_copyIvarList([self class], &count);
    
    for (int i=0;i < count; i++) {
        Ivar ivar = ivarArray[i];
        
        // 属性名
        NSString* propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 去掉前面那个 _ 下划线
        propertyName = [propertyName substringFromIndex:1];
        
        // 属性类型
        NSString* propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // 去掉 @"NString" 类型的 @"" 字符串
        propertyType  = [propertyType stringByReplacingOccurrencesOfString:@"@\"" withString:@""];
        propertyType  = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        // 判断如果不是系统类型、NS开头的类型就是用户自定义类型，就进行递归创建该实例
        if (propertyType.length > 1 && ![propertyType hasPrefix:@"NS"]) {
            
            // 创建该属性的类
            Class class = NSClassFromString(propertyType);
            
            // 创建子对象
            id subObj = [class instanceWithDic:dic[propertyName]];
            
            // 设置属性值
            if (subObj) {
                [_self setValue:subObj forKey:propertyName];
            }
        }else{
            
            // 设置属性值
            if (![dic[propertyName] isEqual:[NSNull null]] && dic[propertyName] != nil) {
                [_self setValue:dic[propertyName] forKey:propertyName];
            }
        }
        
        // NSLog(@"%@  %@",propertyName,propertyType);
    }
    
    return _self;
}
@end
