//
//  CBISearchModel.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/19.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBISearchModel.h"
#import "CBIRules.h"

@implementation CBISearchModel{
    CBIBoard *_board;
}

-(CBCAlpaBetaNode *)search2:(CBIBoard *)board{
    _board = board;
    NSInteger size = [board.pieceMap allKeys].count;
    int random = [self getRandomNumber:0 to:size];
    NSArray *moves = [self generate];
    CBCAlpaBetaNode *best = moves[random];
    return best;
}
-(NSArray *)generate{
    NSMutableArray *moves = [NSMutableArray array];
    NSArray * array = [_board.pieceMap allKeys];
    for (NSString *key in array) {
        CBCPiece *piece = _board.pieceMap[key];
        if ([piece.key characterAtIndex:0]=='b') {
            for (CBLocation * loc in [CBIRules getNextMoveWithPiece:key location:piece.location board:_board]) {
                CBCAlpaBetaNode *bn = [[CBCAlpaBetaNode alloc]initWithPieceKey:key from:piece.location to:loc];
                [moves addObject:bn];
                
            }
        }
        
    }
    return moves;
}


-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}
@end
