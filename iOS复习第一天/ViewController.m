//
//  ViewController.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

#import "ViewController.h"
#import "SQL3Manager.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *testTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)deleteStudent:(id)sender {
    static NSInteger l = 0;
    Student *one = [[Student alloc] init];
    one.name = [NSString stringWithFormat:@"李明星%.2ld号", l++];
    one.number = l;
    one.age = 25;
    one.sex = @"男";
    SQL3Manager *manager = [[SQL3Manager alloc] init];
    [manager deleteStudent:one];
}

- (IBAction)updateStudent:(id)sender {
    static NSInteger m = 0;
    SQL3Manager *manager = [[SQL3Manager alloc] init];
    Student *one = [[Student alloc] init];
    one.name = [NSString stringWithFormat:@"李明星%.2ld号", m++];
    one.number = 0;
    one.age = 25;
    one.sex = @"男";
    [manager updateStudent:one];
}
- (IBAction)readStudent:(id)sender {
    SQL3Manager *manager = [[SQL3Manager alloc] init];
    NSArray *ary = [manager selectAllStudent];
    for (NSInteger i = 0; i < ary.count; i++) {
        Student *stu = ary[i];
        NSLog(@"%@--%ld",stu.name, stu.number);
    }
}
- (IBAction)addStudent:(id)sender {
    static NSInteger i = 0;
    SQL3Manager *manager = [[SQL3Manager alloc] init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [manager openDatabase];
        [manager createTable];
    });
    Student *one = [[Student alloc] init];
    one.name = [NSString stringWithFormat:@"李明星%.2ld号", i];
    one.number = i++;
    one.age = 25;
    one.sex = @"男";
    [manager addStudent:one];
}
- (IBAction)readSomeInfo:(id)sender {
    NSString *str = [NSString stringWithContentsOfFile:[self getFilePath] encoding:NSUTF8StringEncoding error:nil];
    self.testTF.text = str;
}

//获取文件路径
- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"123.plist"];//文件不存在会自动创建
    return path;
}

- (IBAction)storeSomeInfo:(id)sender {
    NSString *str = self.testTF.text;
    if (!str.length) {
        return;
    }
    //第一步获取目路径
    /**  atomically是先复制辅助文件，然后将辅助文件写入沙盒，更安全，默认选YES*/
    NSLog(@"%@", [self getFilePath]);
    NSError *error;
    BOOL ret = [str writeToFile:[self getFilePath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    BOOL ret = [ary writeToFile:[self getFilePath] atomically:YES];
    if (ret) {
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败%@", error);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.testTF resignFirstResponder];
}

@end
