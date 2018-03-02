//
//  User.h
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy)NSString* profile_image_url;

@property (nonatomic,assign)BOOL vip;

@property (nonatomic,copy)NSString* name;

@property (nonatomic,assign)NSInteger mbrank;

@property (nonatomic,assign)NSInteger mbtype;

@end
