//
//  CBIRules.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBIBoard.h"

@interface CBIRules : NSObject


@property(nonatomic,strong)CBLocation *location;
@property(nonatomic,strong)CBIBoard *board;
@property(nonatomic,assign)char player;

+(NSArray *)getNextMoveWithPiece:(NSString *)piece location:(CBLocation *)loc board:(CBIBoard *)board;

@end
