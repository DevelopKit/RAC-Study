//
//  testFlattenMap.m
//  RAC-Study
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testFlattenMap : XCTestCase

@end

@implementation testFlattenMap


- (void)testRACSequence1 {
    RACSequence *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *flattenMap = [numbers flattenMap:^RACStream *(NSString *value) {
        return @[value,value].rac_sequence;
    }];
    [flattenMap.signal subscribeNext:^(id x) {
        NSLog(@"value is %@",x);
    } completed:^{
       NSLog(@"complete");
    }];
    
    //1 1 2 2 3 3 4 4 5 5 6 6
}
- (void)testRACSequence2 {
    RACSequence *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *flattenMap = [numbers flattenMap:^RACStream *(NSString *value) {
        if (value.integerValue %2 == 0) {
            return [RACSequence empty];
        } else {
            return [RACSequence return:[value stringByAppendingString:value]];
        }
    }];
    [flattenMap.signal subscribeNext:^(id x) {
        NSLog(@"value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    
    //11 22 33 44 55 66
}
- (void)testRACSignal{
    RACSignal *numbers = [@"A B C D E F" componentsSeparatedByString:@" "].rac_sequence.signal;
    RACSignal *flattenMap = [numbers flattenMap:^RACStream *(NSString * value) {
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:[value stringByAppendingString:value]];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [flattenMap subscribeNext:^(id x) {
        NSLog(@"value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];

    //AA BB CC DD EE FF
}

@end
