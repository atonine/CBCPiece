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
        n.value =[self alphaBeta:DEPTH alpha:NSIntegerMin beta:NSIntegerMax isMax:NO];
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
-(CBCAlpaBetaNode *)search2:(CBCBoard *)board{
    _board = board;
    NSInteger size = [board.pieceMap allKeys].count;
    int random = [self getRandomNumber:0 to:size];
    NSArray *moves = [self generate];
    CBCAlpaBetaNode *best = moves[random];
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
        
   //      NSInteger temp;
        if (depth == 2) {
            if (isMax) {
                alpha = MAX(c_alpha, [self alphaBeta:c_depth-1 alpha:c_alpha beta:c_beta isMax:NO]);
                
               
            }else{
                
                beta = MIN(c_beta, [self alphaBeta:c_depth-1 alpha:c_alpha beta:c_beta isMax:YES]);
                
            }
        }else{
            if (isMax) {
                alpha = MAX(alpha, [self alphaBeta:depth-1 alpha:alpha beta:beta isMax:NO]);
            }else{
                beta = MIN(beta, [self alphaBeta:depth-1 alpha:alpha beta:beta isMax:YES]);
            }
        }
        [_board updatePiece:n.piece newLocation:n.from];
        if (eaten !=nil) {
            [_board.pieceMap setValue:eaten forKey:eaten.key];
            [_board backPiece:eaten.key];
        }
        if (beta<=alpha) {
            break;
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
-(NSArray *)generate{
    NSMutableArray *moves = [NSMutableArray array];
    NSArray * array = [_board.pieceMap allKeys];
    for (NSString *key in array) {
        CBCPiece *piece = _board.pieceMap[key];
        if ([piece.key characterAtIndex:0]=='b') {
            for (CBLocation * loc in [CBCRules getNextMoveWithPiece:key location:piece.location board:_board]) {
                CBCAlpaBetaNode *bn = [[CBCAlpaBetaNode alloc]initWithPieceKey:key from:piece.location to:loc];
                [moves addObject:bn];
                
            }
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
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}
@end
