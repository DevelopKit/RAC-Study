//
//  testFlatten.m
//  RAC-Study
//
//  Created by NaCai on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testFlatten : XCTestCase

@end

@implementation testFlatten


- (void)testRACSequence{
    RACSequence *numbers = [@"1 2 3 4 5 6" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *letters = [@"A B C D E F" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *sequence = @[numbers,letters].rac_sequence;
    [[sequence flatten].signal subscribeNext:^(id x) {
       NSLog(@"value is %@",x);
    }];
}

- (void)testRACSignal{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *signalOfSignals = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *flattened = [signalOfSignals flatten];
    [flattened subscribeNext:^(id x) {
        NSLog(@"value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];

    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"2"];
    [numbers sendNext:@"3"];
    [letters sendCompleted];
    [numbers sendCompleted];
}
@end
