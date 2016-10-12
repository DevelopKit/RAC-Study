//
//  People.m
//  RAC-Study
//
//  Created by NaCai on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import "People.h"


@implementation House
-(instancetype)init{
    self = [super init];
    if (self) {
        self.address = @"Beijing";
    }
    return self;
}
@end


@implementation People

-(instancetype)init{
    self = [super init];
    if (self) {
        self.name = @"Tom";
        self.currentHouse = [House new];
        self.houses = @[[House new],[House new],[House new]];
    }
    return self;
}

- (void)walk{
    [self walkDirection:WalkDirectionLeft];
}
- (void)walkDirection:(WalkDirection)direction{
    [self walkDirection:direction miles:100];
}
- (void)walkDirection:(WalkDirection)direction miles:(float)miles{
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
