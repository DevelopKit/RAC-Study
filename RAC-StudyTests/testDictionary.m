//
//  testDictionary.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testDictionary : XCTestCase
{
    NSDictionary *dictionary;
}
@end

@implementation testDictionary

- (void)setUp {
    [super setUp];
    dictionary = @{
                   @"1":@"A",
                   @"2":@"B",
                   @"3":@"C",
                   @"4":@"D"};
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAll{
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple *tuple) {
        NSLog(@"key is %@,value is %@",tuple.first,tuple.second);
    } completed:^{
        NSLog(@"complete");
    }];
    //顺序和写入的顺序不一样
}

- (void)testKeys{
    [dictionary.rac_keySequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"key is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
}
- (void)testValues{
    [dictionary.rac_valueSequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
}

@end
