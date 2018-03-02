//
//  Status.h
//  字典转模型
//
//  Created by xgao on 16/7/15.
//  Copyright © 2016年 xgao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "User.h"

@interface Status : BaseModel

@property (nonatomic,assign)NSInteger id;

@property (nonatomic,copy)NSString* text;

@property (nonatomic,assign)NSInteger attitudes_count;

@property (nonatomic,assign)NSInteger comments_count;

@property (nonatomic,strong)User* user;

@property (nonatomic,strong)NSDictionary* retweeted_status;

@property (nonatomic,copy)NSString* created_at;

@property (nonatomic,copy)NSString* idstr;

@property (nonatomic,copy)NSString* source;

@property (nonatomic,assign)NSInteger reposts_count;

@property (nonatomic,strong)NSArray* pic_urls;

@end
