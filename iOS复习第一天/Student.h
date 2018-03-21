//
//  Student.h
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject<NSCoding>

@property (assign, nonatomic) NSInteger number;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) NSInteger age;

@end
