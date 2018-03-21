

//
//  CoreDataViewController.m
//  iOS复习第一天
//
//  Created by LiMingXing on 2018/3/21.
//  Copyright © 2018年 李明星. All rights reserved.
//

//注意创建对象文件的时候选好语言种类切换和设置Codegen 为“Manual/None”

#import "CoreDataViewController.h"
#import <CoreData/CoreData.h>
#import "StudentCoreData+CoreDataClass.h"

@interface CoreDataViewController ()

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *ageTF;
@property (strong, nonatomic) IBOutlet UITextField *numberTF;

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openCoreData:(id)sender {
    //获取模型路径
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:path];
    //创建数据库
    //利用模型对象创建助理
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSError *error;
    [store addPersistentStoreWithType:NSSQLiteStoreType
                        configuration:nil URL:[NSURL fileURLWithPath:sqlPath]
                              options:nil error:&error];
    if (error) {
        NSLog(@"添加数据库失败%@", error);
    }else{
        NSLog(@"数据库创建成功");
    }

    //创建上下文对象，操作数据库
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = store;
    _context = context;
}
- (IBAction)addOne:(id)sender {
    static NSInteger i = 0;
    StudentCoreData *one = [NSEntityDescription insertNewObjectForEntityForName:@"StudentCoreData" inManagedObjectContext:self.context];;
    one.name = @"李明星";
    one.age = 25;
    one.number = i++;
    one.sex = @"男";
    NSError *error;
    if ([self.context save:&error]) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败%@",error);
    }
    
}

- (IBAction)deleteOne:(id)sender {
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"StudentCoreData"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %ld", 10];
    deleRequest.predicate = pre;
    NSArray *deleAry = [self.context executeFetchRequest:deleRequest error:nil];
    for (StudentCoreData *stu in deleAry) {
        [self.context deleteObject:stu];
    }
    NSError *error;
    if ([self.context save:&error]) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败%@",error);
    }
}
- (IBAction)updateOne:(id)sender {
    NSFetchRequest *updateRequest = [NSFetchRequest fetchRequestWithEntityName:@"StudentCoreData"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name= %@",@"李明星"];
    updateRequest.predicate = pre;
    NSArray *queryAry = [self.context executeFetchRequest:updateRequest error:nil];
    for (StudentCoreData *stu in queryAry) {
        stu.name = @"郝雪梅";
    }
    NSError *error;
    if ([self.context save:&error]) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败%@",error);
    }
}
- (IBAction)queryAll:(id)sender {
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StudentCoreData"];
    //查询条件
//    NSPredicate *pre = [NSPredicate pre];
//    request.predicate = pre;
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    // 每页显示多少条数据
    //request.fetchLimit = 6;
    
    //发送查询请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    for (StudentCoreData *stu in resArray) {
        NSLog(@"%@", stu.name);
    }
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
