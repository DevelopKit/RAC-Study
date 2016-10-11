//
//  testLift.m
//  RAC-Study
//
//  Created by ZhaiQiang on 16/10/11.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef NS_ENUM(NSInteger,WalkDirection){
    WalkDirectionLeft,
    WalkDirectionRight,
    WalkDirectionUp,
    WalkDirectionDown
};

@interface People : NSObject

@end

@implementation People

- (void)walk{
    [self walkDirection:WalkDirectionLeft];
}
- (void)walkDirection:(WalkDirection)direction{
    [self walkDirection:direction miles:100];
}
- (void)walkDirection:(WalkDirection)direction miles:(CGFloat)miles{
    NSString *d = nil;
    switch (direction) {
        case WalkDirectionUp:
            d = @"UP";
            break;
        case WalkDirectionDown:
            d = @"DOWN";
            break;
        case WalkDirectionLeft:
            d = @"LEFT";
            break;
        default:
            d = @"RIGHT";
            break;
    }
    NSLog(@"i walk %@ with %@ miles",d,@(miles).stringValue);
}
- (NSString *)nameForLanguage:(NSString *)language{
    if ([language isEqualToString:@"en"]) {
        return @"Tom";
    }else if ([language isEqualToString:@"cn"]){
        return @"张三";
    }else{
        return @"你在说啥子";
    }
}
@end

@interface testLift : XCTestCase

@end

@implementation testLift

//这是个错误的示范，因为我们要执行的selector是不接受参数的
- (void)testSelectorWithNoArgument{
    RACSubject *subject = [RACSubject subject];
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(walk) withSignals:subject, nil];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    [subject sendNext:@(WalkDirectionLeft)];
    [subject sendNext:@(WalkDirectionDown)];
    [subject sendCompleted];
}

- (void)testSelectorWithOneArgument{
    RACSubject *direction = [RACSubject subject];
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(walkDirection:) withSignals:direction, nil];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        //因为没有返回值，所以这里传递的值为RACUnit
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    [direction sendNext:@(WalkDirectionLeft)];
    [direction sendNext:@(WalkDirectionDown)];
    [direction sendCompleted];
}
- (void)testSelectorWithTwoArgument1{
    RACSubject *direction = [RACSubject subject];
    RACSubject *miles = [RACSubject subject];
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(walkDirection:miles:) withSignals:direction,miles, nil];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        //因为没有返回值，所以这里传递的值为RACUnit
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    [direction sendNext:@(WalkDirectionLeft)];
    [direction sendNext:@(WalkDirectionDown)];
    [direction sendCompleted];
    [miles sendNext:@(50)];
    [miles sendNext:@(150)];
    [miles sendCompleted];
}
- (void)testSelectorWithTwoArgument2{
    RACSubject *direction = [RACSubject subject];
    RACSubject *miles = [RACSubject subject];
    
    RACSignal *combineSignal = [RACSignal combineLatest:@[direction,miles]];
    
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(walkDirection:miles:) withSignalOfArguments:combineSignal];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        //因为没有返回值，所以这里传递的值为RACUnit.defaultUnit
        NSLog(@"%@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    [direction sendNext:@(WalkDirectionLeft)];
    [direction sendNext:@(WalkDirectionDown)];
    [direction sendCompleted];
    [miles sendNext:@(50)];
    [miles sendNext:@(150)];
    [miles sendCompleted];
}
- (void)testSelectorWithReturnValue{
    RACSubject *language = [RACSubject subject];
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(nameForLanguage:) withSignals:language, nil];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    
    [language sendNext:@"en"];
    [language sendNext:@"cn"];
    [language sendNext:@"jp"];
    [language sendCompleted];
}

- (void)testSelectorWithReturnValueReplay{
    RACSubject *language = [RACSubject subject];
    People *people = [People new];
    RACSignal *liftSignal = [people rac_liftSelector:@selector(nameForLanguage:) withSignals:language, nil];
    [liftSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"first subscribe value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    
    [language sendNext:@"en"];
    [language sendNext:@"cn"];
    [language sendNext:@"jp"];
    
    //基于Replay特性，订阅之后会立马获得其最新值
    [liftSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"second subscribe value is %@",x);
    } completed:^{
        NSLog(@"complete");
    }];
    [language sendNext:@"en"];
    [language sendNext:@"cn"];
    [language sendNext:@"jp"];

    [language sendCompleted];
}

@end
