//
//  Macros.h
//  RAC-Study
//
//  Created by NaCai on 16/10/12.
//  Copyright © 2016年 ZhaiQiang. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define COMPLETE \
^{\
NSLog(@"complete");\
}

#define SUBSCRIBE \
subscribeNext:^(id x) {\
NSLog(@"value is %@",x);\
} error:^(NSError *error) {\
    NSLog(@"error");\
} completed:^{\
    NSLog(@"complete");\
}

#endif /* Macros_h */
