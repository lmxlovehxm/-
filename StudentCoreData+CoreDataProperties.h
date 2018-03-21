//
//  StudentCoreData+CoreDataProperties.h
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//
//

#import "StudentCoreData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentCoreData (CoreDataProperties)

+ (NSFetchRequest<StudentCoreData *> *)fetchRequest;

@property (nonatomic) int64_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t number;
@property (nullable, nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
