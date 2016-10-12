//
//  testTuple.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
@interface testTuple : XCTestCase

@end

@implementation testTuple

- (void)testTuple1{
    RACTupleUnpack(NSString *name,NSNumber *age) = RACTuplePack(@"Tom",@20);
    NSLog(@"name is %@",name);
    NSLog(@"age is %@",age.stringValue);
}
- (void)testTuple2{
    RACTuple *tuple = [RACTuple tupleWithObjects:@"Tom",@20, nil];
    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
    NSLog(@"name is %@",name);
    NSLog(@"age is %@",age.stringValue);
}
- (void)testTuple3{
    RACTuple *tuple = RACTuplePack(@"Tom",@20);
    NSLog(@"name is %@",tuple.first);
    NSLog(@"age is %@",tuple.second);
}
@end
