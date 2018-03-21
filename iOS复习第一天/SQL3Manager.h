//
//  SQL3Manager.h
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface SQL3Manager : NSObject

- (void)openDatabase;
- (void)createTable;
- (void)addStudent:(Student *)Student;
- (void)deleteStudent:(Student *)Student;
- (void)updateStudent:(Student *)Student;
- (NSMutableArray *)selectAllStudent;
- (void)closeSqlite;
@end
