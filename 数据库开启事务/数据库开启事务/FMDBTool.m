//
//  FMDBTool.m
//  数据库开启事务
//
//  Created by navchina on 2017/8/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "FMDBTool.h"

@interface FMDBTool ()

@property (nonatomic, strong) FMDatabase *DB;

@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;

@end

@implementation FMDBTool
static FMDBTool *fmdbTool = nil;
+(FMDBTool *)shareDatsbase{

    static dispatch_once_t token ;
    dispatch_once(&token, ^{
        
        fmdbTool = [[self alloc]init];
        [fmdbTool createDerctory];
    });
    return fmdbTool;
}

//打开数据库
-(void)createDerctory{

//    判断有没有数据库文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *uidPath = documentDirectory;

    NSString *DBFilePath = [uidPath stringByAppendingPathComponent:@"DBinfo.db"];
    
    self.DB = [FMDatabase databaseWithPath:DBFilePath];
        
    self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:DBFilePath];
    
    if (![self.DB open]) {
        NSLog(@"打开失败");
    }else{
        NSLog(@"打开成功");
    }
    //建表
    [self createtable];
}

//建表
-(void)createtable{

    if (![self.DB open]) {
        return;
    }
    
    [self.DB executeUpdate:@"create table if not exists GroupPersonInfo(uid text,phone text,name text,roomId text)"];
    //关闭数据库
    [self.DB close];
}

-(void)testDBSpeed{
    NSDate *date1 = [NSDate date];
    [self insertData:500 userTransaction:NO];
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"不使用事务插入500条数据的时间%.3f秒",a);
    [self insertData:1000 userTransaction:YES];
    NSDate *date3 = [NSDate date];
    NSTimeInterval b = [date3 timeIntervalSince1970] - [date2 timeIntervalSince1970];
     NSLog(@"使用事务插入500条数据的时间%.3f秒",b);
    
}

-(void)insertData:(int)fromIndex userTransaction:(BOOL)useTransaction{
    if (![self.DB open]) {
        return;
    }
    if (useTransaction) {
        [self.DB beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for (int i = 0; i<fromIndex; i++) {
                NSString *nId = [NSString stringWithFormat:@"%d",i];
                NSString *phone= [[NSString alloc] initWithFormat:@"phone_%d",i];
                NSString *strName = [[NSString alloc] initWithFormat:@"name_%d",i];
                NSString *roomID= [[NSString alloc] initWithFormat:@"roomid_%d",i];
                NSString *sql = @"insert into GroupPersonInfo(uid,phone,name,roomId) values(?,?,?,?)";
                BOOL a = [self.DB executeUpdate:sql,nId,phone,strName,roomID];
                if (!a) {
                    NSLog(@"插入失败");
                }
                
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [self.DB rollback];
        } @finally {
            if (!isRollBack) {
                
                [self.DB commit];
            }
        }
    }else{
    
        for (int i = fromIndex; i<fromIndex + 500 ; i++) {
            NSString *nId = [NSString stringWithFormat:@"%d",i];
            NSString *phone= [[NSString alloc] initWithFormat:@"phone_%d",i];
            NSString *strName = [[NSString alloc] initWithFormat:@"name_%d",i];
            NSString *roomID= [[NSString alloc] initWithFormat:@"roomid_%d",i];
            NSString *sql = @"insert into GroupPersonInfo(uid,phone,name,roomId) values(?,?,?,?)";
            BOOL a = [self.DB executeUpdate:sql,nId,phone,strName,roomID];
            if (!a) {
                NSLog(@"插入失败");
            }
    }
    }
    [self.DB close];
}


@end
