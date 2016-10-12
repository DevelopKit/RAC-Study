//
//  testKVO.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "People.h"
#import "Macros.h"

@interface testKVO : XCTestCase

@end

@implementation testKVO

- (void)testBasicUse{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@"name" observer:self] SUBSCRIBE];
    
    people.name = @"Jerry";
}
- (void)testKeypathWithObjAndPath1{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@keypath(people,name) observer:self] SUBSCRIBE];
    people.name = @"Jerry";
}
- (void)testKeypathWithObjAndPath2{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@keypath(People.new,name) observer:self] SUBSCRIBE];
    people.name = @"Jerry";
}
- (void)testKeypathWithPath{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@keypath(people.name) observer:self] SUBSCRIBE];
    people.name = @"Jerry";

}
- (void)testKeypathWithSubObjAndPath{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@keypath(people,currentHouse.address) observer:self] SUBSCRIBE];
    people.currentHouse.address = @"ShangHai";

}
- (void)testKeypathWithSubPath{
    People *people = [People new];
    [[people rac_valuesForKeyPath:@keypath(people.currentHouse.address) observer:self] SUBSCRIBE];
    people.currentHouse.address = @"ShangHai";
    
}
- (void)testCollectionKVO{
//    People *people = [People new];
//    NSString *keypath = @collectionKeypath(people.houses,House.new,address);
//    NSLog(@"keypath is %@",keypath);
//    [[people.houses rac_valuesForKeyPath:keypath observer:self] SUBSCRIBE];
//    people.name = @"Jerry";
//    House *house = [people.houses firstObject];
//    house.address = @"ShangHai";
}
- (void)testKVOWithOptions{
    People *people = [People new];
    [[people rac_valuesAndChangesForKeyPath:@keypath(people.name) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:self] SUBSCRIBE];
    people.name = @"Jerry";
}
@end
