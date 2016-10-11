//
//  testSwitch.m
//  RAC-Study
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testSwitch : XCTestCase

@end

@implementation testSwitch

- (void)testSwitch{
    RACSubject *numbers = [RACSubject subject];
    RACSubject *letters = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    [[signalOfSignals switchToLatest] subscribeNext:^(id x) {
       NSLog(@"value is %@",x);
    }];

    [signalOfSignals sendNext:numbers];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"3"];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];

    //1 2 A B
}

@end
