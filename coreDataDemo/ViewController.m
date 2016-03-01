//
//  ViewController.m
//  coreDataDemo
//
//  Created by 福子 on 16/2/29.
//  Copyright (c) 2016年 福子. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Clothes.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)AppDelegate *myAppdelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //初始化数组
    self.dataSource = [NSMutableArray array];
    self.myAppdelegate = [[UIApplication sharedApplication]delegate];
    //查询数据
    //1、创建fetch对象
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Clothes"];
    //2、设置排序
    //创建排序描述对象
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
   // request.sortDescriptors = @[sortDescriptor] ;
    //3、执行查询请求
    NSError *err;
    NSArray * arr = [[self.myAppdelegate managedObjectContext]executeFetchRequest:request error:&err];
    NSLog(@"%@",err.localizedDescription);
    //4、给数据源数组添加数据
    NSMutableArray *test = [NSMutableArray array];
    [self.dataSource addObjectsFromArray:arr];
}
#pragma mark -tbaleView的delegate和datasource方法实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Clothes *clothes = [self.dataSource objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@+++v+%@",clothes.name,clothes.price];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源
        Clothes *cloth = [self.dataSource objectAtIndex:[indexPath row]];
        [self.dataSource removeObject:cloth];
        [self.tableView reloadData];
        //删除数据库中的数据
        [self.myAppdelegate.managedObjectContext deleteObject:cloth];
        [self.myAppdelegate saveContext];
    }

}
//点击cell修改数据

//tableView可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //找到模型对象
    Clothes *cloth = [self.dataSource objectAtIndex:[indexPath row]];
    cloth.price =@1111;
    //刷新ui
    [self.tableView reloadData];
    
    //保存到数据库
    [self.myAppdelegate saveContext];

}
//插入数据
- (IBAction)addModel:(id)sender {
    //创建实体描述
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Clothes" inManagedObjectContext:self.myAppdelegate.managedObjectContext];
    //1 创建一个模型对象
    Clothes *cloth = [[Clothes alloc]initWithEntity:description insertIntoManagedObjectContext:self.myAppdelegate.managedObjectContext];
    cloth.name = @"me";
    int price = arc4random()%1000+1;
    cloth.price = [NSNumber numberWithInt:price];
    //插入数据源数组
    [self.dataSource addObject:cloth];
    //更新ui
    [self.myAppdelegate saveContext];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
