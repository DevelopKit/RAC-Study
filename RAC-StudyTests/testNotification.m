//
//  testNotification.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "Macros.h"
@interface testNotification : XCTestCase

@end

@implementation testNotification

- (void)testExample {
    NSObject *obj = [NSObject new];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"notification" object:nil] takeUntil:[obj rac_willDeallocSignal]] SUBSCRIBE];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:@"info"];
}


@end
