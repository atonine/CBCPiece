//
//  CBCSearchModel.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/27.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCSearchModel.h"
#import "CBCAlpaBetaNode.h"
#import "CBCRules.h"

static int DEPTH = 2;



@implementation CBCSearchModel{
    CBCBoard *_board;
    
}
/**
 qipan
 */

-(CBCAlpaBetaNode *)search:(CBCBoard *)board{
    _board = board;
    NSInteger size = [board.pieceMap allKeys].count;
    if (size<28) {
        DEPTH = 3;
    }
    if (size<16) {
        DEPTH = 4;
    }if (size<6) {
        DEPTH = 5;
    }if (size<4) {
        DEPTH = 6;
    }
    long startTime = (double)[[NSDate date]timeIntervalSince1970];
    CBCAlpaBetaNode *best = nil;
    NSArray *moves = [self generateMovesForAll:YES];
    for (CBCAlpaBetaNode *n in moves) {
        CBCPiece *eaten = [_board updatePiece:n.piece newLocation:n.to];
        
        
    }
    return nil;
}

-(NSArray *)generateMovesForAll:(BOOL)isMax{
    NSMutableArray *moves = [NSMutableArray array];
    NSArray * array = [_board.pieceMap allKeys];
    for (NSString *key in array) {
        CBCPiece *piece = _board.pieceMap[key];
        if (isMax&&piece.color == 'r') {
            continue;
        }if (!isMax && piece.color == 'b') {
            continue;
        }
        for (CBLocation * loc in [CBCRules getNextMoveWithPiece:key location:piece.location board:_board]) {
            CBCAlpaBetaNode *bn = [[CBCAlpaBetaNode alloc]initWithPieceKey:key from:piece.location to:loc];
            [moves addObject:bn];
        }
    }
    return moves;
}

@end
