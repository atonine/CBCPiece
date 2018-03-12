//
//  CBCAlpaBetaNode.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/21.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCAlpaBetaNode.h"

@implementation CBCAlpaBetaNode

-(instancetype)initWithPieceKey:(NSString *)key from:(CBLocation *)from to:(CBLocation *)to{
    self = [super init];
    if (self) {
        self.piece = key;
        self.from = from;
        self.to = to;
        
    }
    return self;
}

@end
