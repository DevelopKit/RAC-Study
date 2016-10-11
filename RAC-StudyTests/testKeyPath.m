//
//  testKeyPath.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface Employee : NSObject
@property (nonatomic, strong) NSString *name;
@end
@implementation Employee

@end

@interface Department : NSObject
@property (nonatomic, strong) NSArray *employees;
@end
@implementation Department


@end
@interface testKeyPath : XCTestCase

@end

@implementation testKeyPath

- (void)testMacro{
    NSString *lowercaseStringPath = @keypath(NSString.new, lowercaseString);
    NSLog(@"%@",lowercaseStringPath);
    
    NSString *employessFirstNamePath = @collectionKeypath(Department.new, employees, Employee.new, name);
    NSLog(@"%@",employessFirstNamePath);

}

@end
