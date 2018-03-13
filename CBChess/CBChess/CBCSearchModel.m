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
#import "CBCGameControl.h"
#import "CBCEvalModel.h"
static int DEPTH = 2;

@interface CBCSearchModel()

/**
 ctrl
 */
@property (nonatomic,strong) CBCGameControl *control;

@end

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
  //  long startTime = (double)[[NSDate date]timeIntervalSince1970];
    CBCAlpaBetaNode *best = nil;
    NSArray *moves = [self generateMovesForAll:YES];
    for (CBCAlpaBetaNode *n in moves) {
        CBCPiece *eaten = [_board updatePiece:n.piece newLocation:n.to];
        n.value =[self alphaBeta:DEPTH alpha:NSIntegerMax beta:NSIntegerMax isMax:NO];
        if (best == nil || n.value >= best.value)
            best = n;
        [_board updatePiece:n.piece newLocation:n.from];
        if (eaten!=nil) {
            [board.pieceMap setValue:eaten forKey:eaten.key];
            [board backPiece:eaten.key];
        }
    }
    return best;
}
-(NSInteger)alphaBeta:(NSInteger)depth alpha:(NSInteger)alpha beta:(NSInteger)beta isMax:(BOOL)isMax{
    
    if (depth==0||[self.control hasWin:_board]!='x') {
        CBCEvalModel *model = [[CBCEvalModel alloc]init];
        return [model eval:_board player:'b'];
    }
    NSArray *moves = [self generateMovesForAll:isMax];
    for (const CBCAlpaBetaNode *n in moves) {
        CBCPiece *eaten = [_board updatePiece:n.piece newLocation:n.to];
        const NSInteger c_alpha = alpha;
        const NSInteger c_beta = beta;
        const NSInteger c_depth = depth;
        __block NSInteger temp;
        if (depth == 2) {
            if (isMax) {
                dispatch_queue_t queue = dispatch_queue_create("hmj", DISPATCH_QUEUE_SERIAL);
                dispatch_async(queue, ^{
                    temp = MAX(c_alpha, [self alphaBeta:c_depth-1 alpha:c_alpha beta:c_beta isMax:NO]);
                });
                alpha = temp;
            }else{
                dispatch_queue_t queue = dispatch_queue_create("hmk", DISPATCH_QUEUE_SERIAL);
                dispatch_async(queue, ^{
                    temp = MAX(c_alpha, [self alphaBeta:c_depth-1 alpha:c_alpha beta:c_beta isMax:YES]);
                });
                beta = temp;
            }
        }else{
            if (isMax) {
                alpha = MAX(alpha, [self alphaBeta:depth-1 alpha:alpha beta:beta isMax:NO]);
            }else{
                beta = MAX(beta, [self alphaBeta:depth-1 alpha:alpha beta:beta isMax:YES]);
            }
        }
        if (eaten !=nil) {
            [_board.pieceMap setValue:eaten forKey:eaten.key];
            [_board backPiece:eaten.key];
        }
    }
    return isMax ? alpha : beta;
    
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
-(instancetype)init{
    self = [super init];
    if (self) {
        _control = [[CBCGameControl alloc]init];
    }
    return self;
}
@end
