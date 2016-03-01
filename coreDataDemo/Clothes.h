//
//  Clothes.h
//  coreDataDemo
//
//  Created by 福子 on 16/2/29.
//  Copyright (c) 2016年 福子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Clothes : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;

@end
