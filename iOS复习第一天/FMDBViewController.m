//
//  FMDBViewController.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import "FMDBViewController.h"
#import <FMDB.h>
#import "Student.h"

@interface FMDBViewController ()

@property (strong, nonatomic) FMDatabase *db;

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openData:(id)sender {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"Student.db"];
    _db = [FMDatabase databaseWithPath:path];
    if ([_db open]) {
        NSLog(@"打开成功");
        //创建表
        NSString *studentSql = [NSString stringWithFormat:@"create table if not exists 'Student'('number' integer primary key autoincrement not null, 'name' text, 'sex' text, 'age' integer)"];
        [_db executeUpdate:studentSql];
        [_db close];
    }else{
        NSLog(@"打开失败");
    }
    
}
- (IBAction)addNew:(id)sender {
    [_db open];
    static NSInteger i = 0;
    Student *student = [[Student alloc] init];
    student.number = i++;
    student.name = @"李明星";
    student.sex = @"男";
    student.age = 25;
    [_db executeUpdate:[NSString stringWithFormat:@"insert into Student(number, name, sex, age)values('%ld', '%@', '%@', '%ld')",student.number, student.name, student.sex, student.age]];
    [_db close];
}
- (IBAction)deleteOne:(id)sender {
    [_db open];
    static NSInteger m = 0;
    [_db executeUpdate:[NSString stringWithFormat:@"delete from Student where number='%ld'", m++]];
    [_db close];
}

- (IBAction)updateOne:(id)sender {
    [_db open];
    [_db executeUpdate:[NSString stringWithFormat:@"update Student set name='%@'where number='%d'", @"郝雪梅",0]];
    [_db close];
}

- (IBAction)selectAllOne:(id)sender {
    [_db open];
    NSMutableArray *muAry = [NSMutableArray new];
    FMResultSet *set = [_db executeQuery:@"select* from Student"];
    while ([set next]) {
        Student *one = [Student new];
        one.number = [[set stringForColumn:@"number"] integerValue];
        one.name = [set stringForColumn:@"name"];
        one.sex = [set stringForColumn:@"sex"];
        one.age = [[set stringForColumn:@"age"] integerValue];
        NSLog(@"姓名：%@\n性别：%@\n年龄：%ld\n编号：%ld",one.name,one.sex,one.age,one.number);
        [muAry addObject:one];
    }
    [_db close];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
