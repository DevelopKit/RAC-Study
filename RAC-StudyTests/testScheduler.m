//
//  testScheduler.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

#define SCHEDULER(A)\
[scheduler schedule:^{\
NSLog(A);\
}];


@interface testScheduler : XCTestCase

@end

@implementation testScheduler

- (void)testTestScheduler1{
    RACTestScheduler *scheduler = [[RACTestScheduler alloc] init];
    SCHEDULER(@"scheduler 1");
    SCHEDULER(@"scheduler 2");
    SCHEDULER(@"scheduler 3");
    SCHEDULER(@"scheduler 4");
    SCHEDULER(@"scheduler 5");
//    [scheduler step];
}
- (void)testTestScheduler2{
    RACTestScheduler *scheduler = [[RACTestScheduler alloc] init];
    SCHEDULER(@"scheduler 1");
    SCHEDULER(@"scheduler 2");
    SCHEDULER(@"scheduler 3");
    SCHEDULER(@"scheduler 4");
    SCHEDULER(@"scheduler 5");
    [scheduler step:3];
}
- (void)testTestScheduler3{
    RACTestScheduler *scheduler = [[RACTestScheduler alloc] init];
    SCHEDULER(@"scheduler 1");
    SCHEDULER(@"scheduler 2");
    SCHEDULER(@"scheduler 3");
    SCHEDULER(@"scheduler 4");
    SCHEDULER(@"scheduler 5");
    [scheduler stepAll];
}

@end
