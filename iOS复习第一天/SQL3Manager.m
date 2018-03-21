//
//  SQL3Manager.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import "SQL3Manager.h"
#import <sqlite3.h>
#import "Student.h"


static sqlite3 *db;//是指向数据库的指针,我们其他操作都是用这个指针来完成

@implementation SQL3Manager

- (void)openDatabase{
    if (db) {
        NSLog(@"数据库已经打开");
        return;
    }
    //创建路径
    NSString *fileName = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbFileName = [fileName stringByAppendingPathComponent:@"test.sqlite"];
    //打开数据库
    int result = sqlite3_open(dbFileName.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
}

#pragma mark ---------------增删改查-------------------
//创建表格
- (void)createTable{
    //准备sql语句
    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists 'Student'('number' integer primary key autoincrement not null, 'name' text, 'sex' text, 'age' integer)"];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}
//插入数据
- (void)addStudent:(Student *)Student{
    NSString *sqlite = [NSString stringWithFormat:@"insert into Student(number, name, sex, age)values('%ld', '%@', '%@', '%ld')",Student.number, Student.name, Student.sex, Student.age];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

//删除数据
- (void)deleteStudent:(Student *)Student{
    NSString *sqlite = [NSString stringWithFormat:@"delete from Student where number='%ld'",Student.number];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}
//修改数据
- (void)updateStudent:(Student *)Student{
    NSString *sqlite = [NSString stringWithFormat:@"update Student set name='%@', sex= '%@', age = '%ld'where number='%ld'", Student.name, Student.sex, Student.age, Student.number];
    //执行sql语句
    char *error = NULL;
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败");
    }
}

//查询所有数据
- (NSMutableArray *)selectAllStudent{
    NSMutableArray *muAry = [NSMutableArray new];
    NSString *sqlite  = [NSString stringWithFormat:@"select * from Student"];
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);//第4个参数是一次性返回所有的参数,就用-1
    if (result == SQLITE_OK) {
        NSLog(@"查询成功");
        //4.执行n次
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Student *stu = [[Student alloc] init];
            //从伴随指针获取数据,第0列
            stu.number = sqlite3_column_int(stmt, 0);
            //从伴随指针获取数据,第1列
            stu.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
            //从伴随指针获取数据,第2列
            stu.sex = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)] ;
            //从伴随指针获取数据,第3列
            stu.age = sqlite3_column_int(stmt, 3);
            [muAry addObject:stu];
        }
    } else {
        NSLog(@"查询失败");
    }
    //5.关闭伴随指针
    sqlite3_finalize(stmt);
    return muAry;
}

//关闭数据库
- (void)closeSqlite{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
}


@end
