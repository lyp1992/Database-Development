//
//  FMDBTool.h
//  数据库开启事务
//
//  Created by navchina on 2017/8/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface FMDBTool : NSObject

+(FMDBTool *)shareDatsbase;

-(void)testDBSpeed;

@end
