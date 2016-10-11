//
//  testKVO.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface House : NSObject
@property (nonatomic,strong) NSString *address;
@end
@implementation House
-(instancetype)init{
    self = [super init];
    if (self) {
        self.address = @"Beijing";
    }
    return self;
}
@end

@interface Person : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) House *currentHouse;
@property (nonatomic,strong) NSArray *houses;
@end
@implementation Person
-(instancetype)init{
    self = [super init];
    if (self) {
        self.name = @"Tom";
        self.currentHouse = [House new];
        self.houses = @[[House new],[House new],[House new]];
    }
    return self;
}
@end

@interface testKVO : XCTestCase

@end

@implementation testKVO

- (void)test1{
    Person *people = [Person new];
    [[people rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    
    people.name = @"Jerry";
}
- (void)test2{
    Person *person = [Person new];
    [[person rac_valuesForKeyPath:@keypath(person,name) observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    person.name = @"Jerry";

}

- (void)test3{
    Person *person = [Person new];
    NSString *keypath = @collectionKeypath(person.houses,House.new,address);
    NSLog(@"keypath is %@",keypath);
    [[person rac_valuesForKeyPath:keypath observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    person.name = @"Jerry";
    House *house = [person.houses firstObject];
    house.address = @"ShangHai";
}
- (void)test4{
    Person *person = [Person new];
    [[person rac_valuesAndChangesForKeyPath:@keypath(person.name) options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:self] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"%@",tuple.allObjects);
    } completed:^{
        NSLog(@"complete");
    }];
    person.name = @"Jerry";
}
@end
