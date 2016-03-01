//
//  AppDelegate.h
//  coreDataDemo
//
//  Created by 福子 on 16/2/29.
//  Copyright (c) 2016年 福子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//被管理对象上下文，数据管理器，作用是相当于一个临时数据库，
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//被管理对象模型，数据模型器，数据模型器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储助理，数据连接器，整个coredata框架的核心，
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//把临时数据库中的改变进行永久的保存
- (void)saveContext;
//获取真实文件的存储路径
- (NSURL *)applicationDocumentsDirectory;


@end

