//
//  testThen.m
//  RAC-Study
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface testThen : XCTestCase

@end

@implementation testThen

- (void)testThen{
    RACSignal *letters = [@"A B C D E F" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence.signal;
    [[[letters doNext:^(id x) {
        NSLog(@"middle output %@",x);
    }] then:^RACSignal * {
        return numbers;
    }] subscribeNext:^(id x) {
        NSLog(@"final output %@",x);
    }];

    //1 2 3 4 5 6
}

@end
