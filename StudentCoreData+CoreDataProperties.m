//
//  StudentCoreData+CoreDataProperties.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//
//

#import "StudentCoreData+CoreDataProperties.h"

@implementation StudentCoreData (CoreDataProperties)

+ (NSFetchRequest<StudentCoreData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StudentCoreData"];
}

@dynamic age;
@dynamic name;
@dynamic number;
@dynamic sex;

@end
