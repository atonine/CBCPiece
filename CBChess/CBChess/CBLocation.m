//
//  CBLocation.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBLocation.h"

@implementation CBLocation
-(instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        self.x = [array[0] intValue];
        self.y = [array[1] intValue];
    }
    
    return self;
}

@end
