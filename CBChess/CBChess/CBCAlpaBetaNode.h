//
//  CBCAlpaBetaNode.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/21.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCBoard.h"

@interface CBCAlpaBetaNode : NSObject

@property (strong , nonatomic) NSString *piece;

@property(strong , nonatomic)CBLocation *from;

@property(strong , nonatomic)CBLocation *to;

@property(assign , nonatomic)int value;

-(instancetype)initWithPieceKey:(NSString *)key from:(CBLocation *)from to:(CBLocation *)to;
@end
