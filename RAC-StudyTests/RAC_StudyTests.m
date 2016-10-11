//
//  RAC_StudyTests.m
//  RAC-StudyTests
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <ReactiveObjC/ReactiveObjC.h>


@interface RAC_StudyTests : XCTestCase

@end

@implementation RAC_StudyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/*========= merge instance method ============*/
- (void)testMerge{
    RACSignal *signal = [@"1 2 3 4 5 6 7" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *signal1 = [@"A B C D E F G" componentsSeparatedByString:@" "].rac_sequence.signal;
    [[signal merge:signal1] subscribeNext:^(NSString *string) {
        NSLog(@"Instance method - merge string is %@",string);
    }];
//    [[signal1 merge:signal] subscribeNext:^(id x) {
//        NSLog(@"Instance method - merge string is %@",x);
//    }];
//    
//    [[RACSignal merge:@[signal,signal1]] subscribeNext:^(NSString *string) {
//        NSLog(@"Class method - merge string is %@",string);
//    }];
//    [[RACSignal merge:@[signal1,signal]] subscribeNext:^(NSString *string) {
//        NSLog(@"Class method - merge string is %@",string);
//    }];
}
- (void)testMergeSubject{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
//    RACSignal *merged = [RACSignal merge:@[ letters, numbers ]];
    RACSignal *merged = [letters merge:numbers];
    // Outputs: A 1 B C 2
    [merged subscribeNext:^(NSString *x) {
        NSLog(@"%@", x);
    }error:^(NSError * _Nullable error) {
        NSLog(@"error");
    } completed:^{
        NSLog(@"complete");
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
//    [letters sendError:nil];
//    [numbers sendNext:@"3"];
    [numbers sendCompleted];
    [letters sendNext:@"D"];
    [letters sendNext:@"E"];
    [letters sendCompleted];
}
 
- (void)testMap{
    RACSignal *signal = [@"1 2 3 4 5" componentsSeparatedByString:@" "].rac_sequence.signal;
    [[signal map:^id(NSString *value) {
        return [value stringByAppendingString:value];
    }] subscribeNext:^(id x) {
        NSLog(@"map value is %@",x);
    }];
}
- (void)testFilter{
    RACSignal *signal = [@"1 2 3 4 5" componentsSeparatedByString:@" "].rac_sequence.signal;
    [[signal filter:^BOOL(NSString * value) {
        return value.integerValue%2 == 0;
    }] subscribeNext:^(id x) {
        NSLog(@"filter value is %@",x);
    }];
}
- (void)testConcat{
    RACSignal *signal1 = [@"1 2 3 4 5 6 7" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *signal2 = [@"A B C D E F G" componentsSeparatedByString:@" "].rac_sequence.signal;
    [[RACSignal concat:@[signal2,signal1]] subscribeNext:^(id x) {
       NSLog(@"concat value is %@",x);
    }];
}
@end
