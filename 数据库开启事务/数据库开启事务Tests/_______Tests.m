//
//  _______Tests.m
//  数据库开启事务Tests
//
//  Created by navchina on 2017/8/21.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMDBTool.h"
@interface _______Tests : XCTestCase

@end

@implementation _______Tests

- (void)setUp {
    [super setUp];
   
    FMDBTool *fm = [FMDBTool shareDatsbase];
    [fm testDBSpeed];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
