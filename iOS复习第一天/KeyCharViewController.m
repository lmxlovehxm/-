//
//  KeyCharViewController.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import "KeyCharViewController.h"
#import "Student.h"

@interface KeyCharViewController ()

@end

@implementation KeyCharViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getFilePath{
    NSArray *dir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *filePath = [dir.firstObject stringByAppendingPathComponent:@"file.test"];
    return filePath;
}

- (IBAction)archaive:(id)sender {
    Student *sut = [[Student alloc] init];
    sut.name = @"李明星";
    sut.age = 1;
    sut.number = 0;
    sut.sex = @"男";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sut];
    [data writeToFile:[self getFilePath] atomically:YES];
}

- (IBAction)unArchaive:(id)sender {
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
    Student *stu = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@", stu.name);
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
