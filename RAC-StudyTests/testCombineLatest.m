//
//  testCombineLatest.m
//  RAC-Study
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testCombineLatest : XCTestCase

@end

@implementation testCombineLatest

- (void)testCombineLatest{
    RACSubject *numbers = [RACSubject subject];
    RACSubject *letters = [RACSubject subject];
    [[RACSignal combineLatest:@[numbers,letters]] subscribeNext:^(RACTuple *tuple) {
       NSLog(@"value is %@ %@",tuple.first,tuple.second);
    }];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];

    //2A 2B
}
- (void)testCombineLatestReduceEach{
    RACSubject *numbers = [RACSubject subject];
    RACSubject *letters = [RACSubject subject];
    [[[RACSignal combineLatest:@[numbers, letters]] reduceEach:^(NSString *a,NSString *b) {
        return [a stringByAppendingString:b];
    }] subscribeNext:^(id x) {
        NSLog(@"value is %@",x);
    }];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];

    //2A 2B

}
- (void)testCombineLatestReduce{
    RACSubject *numbers = [RACSubject subject];
    RACSubject *letters = [RACSubject subject];
    [[RACSignal combineLatest:@[numbers,letters] reduce:^(NSString *a,NSString *b) {
        return [a stringByAppendingString:b];
    }] subscribeNext:^(NSString *value) {
        NSLog(@"value is %@",value);
    }];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];

    //2A 2B
}
@end
