//
//  CBCRules.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCBoard.h"

@interface CBCRules : NSObject

@property(nonatomic,strong)CBLocation *location;
@property(nonatomic,strong)CBCBoard *board;
@property(nonatomic,assign)char player;

+(NSArray *)getNextMoveWithPiece:(NSString *)piece location:(CBLocation *)loc board:(CBCBoard *)board;


@end
