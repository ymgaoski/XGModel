//
//  ViewController.m
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Model.h"
#import "Status.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* path = [[NSBundle mainBundle]pathForResource:@"status.plist" ofType:nil];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray<NSDictionary*>* array = dic[@"statuses"];
    
    // 生成属性代码
    //[Status createPropertyWithDic:array[0][@"user"]];
    
    NSMutableArray* objArray = [NSMutableArray array];
    
    for (int i=0; i<array.count; i++) {
        // 创建对象,使用 KVC 将字典转对象
//        Status* status = [[Status alloc]initWithDic:array[i]];
        
        // 用到了 Runtime 将字典转对象
        Status* status = [Status instanceWithDic:array[i]];
        
        // Xcode7.2以后好像可以用id关键字做为属性名了,不需要再去重写 setValue: forUndefinedKey: 里面去判断id并重新指定属性值了
        if (status.id == 0) {
            status.id = 88;
        }
        [objArray addObject:status];
    }
    
    
    NSLog(@"count:%i",(int)objArray.count);
}

@end
