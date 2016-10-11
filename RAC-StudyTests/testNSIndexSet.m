//
//  testNSIndexSet.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testNSIndexSet : XCTestCase

@end

@implementation testNSIndexSet

- (void)testIndexSet{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:10];
    [indexSet.rac_sequence.signal subscribeNext:^(NSNumber *  _Nullable x) {
        NSLog(@"%@",x.stringValue);
    } completed:^{
        NSLog(@"complete");
    }];
}
@end
