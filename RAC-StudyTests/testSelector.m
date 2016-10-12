//
//  testSelector.m
//  RAC-Study
//
//  Created by NaCai on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/NSObject+RACSelectorSignal.h>
#import <ReactiveObjC/RACSignal.h>
#import "People.h"
#import "Macros.h"

@interface testSelector : XCTestCase

@end

@implementation testSelector

- (void)testSelectorNo{
    People *people = [People new];
    [[people rac_signalForSelector:@selector(do)] SUBSCRIBE];
    [people walk];
}
- (void)testBasic{
    People *people = [People new];
    [[people rac_signalForSelector:@selector(walk)] SUBSCRIBE];
    [people walk];
}
- (void)testSelectorWithOneArgument{
    People *people = [People new];
    [[people rac_signalForSelector:@selector(walkDirection:)] SUBSCRIBE];
    [people walkDirection:WalkDirectionDown];
}
- (void)testSelectorWithTwoArgument{
    People *people = [People new];
    [[people rac_signalForSelector:@selector(walkDirection:miles:)] SUBSCRIBE];
    [people walkDirection:WalkDirectionDown miles:300];
}
- (void)testSelectorWithReturnValue{
    People *people = [People new];
    [[people rac_signalForSelector:@selector(nameForLanguage:)] SUBSCRIBE];
    [people nameForLanguage:@"en"];
}
- (void)testDelegate{
    [[self rac_signalForSelector:@selector(delegateCallback) fromProtocol:@protocol(People)] SUBSCRIBE];
    [self performSelector:@selector(delegateCallback)];
}
@end
