//
//  ViewController.m
//  数据库开启事务
//
//  Created by navchina on 2017/8/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

//https://github.com/lyp1992/Database-Development.git

#import "ViewController.h"
#import "FMDBTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    FMDBTool *fmdbTool = [FMDBTool shareDatsbase];
    [fmdbTool testDBSpeed];
}


@end
