//
//  People.h
//  RAC-Study
//
//  Created by NaCai on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol People <NSObject>
- (void)delegateCallback;
@end

typedef NS_ENUM(NSInteger,WalkDirection){
    WalkDirectionLeft,
    WalkDirectionRight,
    WalkDirectionUp,
    WalkDirectionDown
};

@interface House : NSObject
@property (nonatomic,strong) NSString *address;
@end

@interface People : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) House *currentHouse;
@property (nonatomic,strong) NSArray *houses;

- (void)walk;

- (void)walkDirection:(WalkDirection)direction;

- (void)walkDirection:(WalkDirection)direction miles:(float)miles;

- (NSString *)nameForLanguage:(NSString *)language;
@end
