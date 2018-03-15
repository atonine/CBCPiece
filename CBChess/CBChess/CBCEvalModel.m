//
//  CBCEvalModel.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/21.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCEvalModel.h"

@implementation CBCEvalModel{
   
}

-(int)eval:(CBCBoard *)board player:(char)player{
     int value[2][2] = {{0,0},{0,0}};
    NSArray *allkeys  = board.pieceMap.allKeys;
    for (NSString *key in allkeys) {
        CBCPiece *piece = board.pieceMap[key];
        int reversePosition[] = {BOARD_HEIGHT - 1 - piece.location.x,piece.location.y};
        CBLocation *reversePositionL = [[CBLocation alloc]init];
        reversePositionL.x = reversePosition[0];
        reversePositionL.y = reversePosition[1];
        switch (piece.character) {
            case 'b':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:0];
                }else{
                    value[1][0] += [self evalPieceValue:0];
                }
                break;
            case 's':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:1];
                }else{
                    value[1][0] += [self evalPieceValue:1];
                }
                break;
            case 'x':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:2];
                }else{
                    value[1][0] += [self evalPieceValue:2];
                }
                break;
            case 'm':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:3];
                    value[0][1] += [self evalPiecePosition:3 position:piece.location];
                }else{
                    value[1][0] += [self evalPieceValue:3];
                    value[1][1] += [self evalPiecePosition:3 position:reversePositionL];
                }
                break;
            case 'j':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:4];
                    value[0][1] += [self evalPiecePosition:4 position:piece.location];
                }else{
                    value[1][0] += [self evalPieceValue:4];
                    value[1][1] += [self evalPiecePosition:4 position:reversePositionL];
                }
                break;
            case 'p':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:5];
                    value[0][1] += [self evalPiecePosition:5 position:piece.location];
                }else{
                    value[1][0] += [self evalPieceValue:5];
                    value[1][1] += [self evalPiecePosition:5 position:reversePositionL];
                }
                break;
                
            case 'z':
                if (piece.color == 'r') {
                    value[0][0] += [self evalPieceValue:6];
                    value[0][1] += [self evalPiecePosition:6 position:piece.location];
                }else{
                    value[1][0] += [self evalPieceValue:6];
                    value[1][1] += [self evalPiecePosition:6 position:reversePositionL];
                }
                break;
            default:
                break;
        }
    }
    int gg = 0;
    int sumRed = value[0][0] + value[0][1] * 8, sumBlack = value[1][0] + value[1][1] * 8;
    switch (player) {
        case 'r':{
            gg = sumRed - sumBlack;
            break;
        }
            
        case 'b':{
            gg = sumBlack - sumRed;
            break;
        }
        default:{
            gg = -1;
            break;
        }
            
    }
    return gg;
}

-(int)evalPieceValue:(int)p{
    int pieceValue[] = {1000000, 110, 110, 300, 600, 300, 70};
    return pieceValue[p];
}
-(int)evalPiecePosition:(int )p position:(CBLocation *)pos{
    int pPosition[10][9] = {
        {6, 4, 0, -10, -12, -10, 0, 4, 6},
        {2, 2, 0, -4, -14, -4, 0, 2, 2},
        {2, 2, 0, -10, -8, -10, 0, 2, 2},
        {0, 0, -2, 4, 10, 4, -2, 0, 0},
        {0, 0, 0, 2, 8, 2, 0, 0, 0},
        {-2, 0, 4, 2, 6, 2, 4, 0, -2},
        {0, 0, 0, 2, 4, 2, 0, 0, 0},
        {4, 0, 8, 6, 10, 6, 8, 0, 4},
        {0, 2, 4, 6, 6, 6, 4, 2, 0},
        {0, 0, 2, 6, 6, 6, 2, 0, 0}
    };
    int mPosition[10][9] = {
        {4, 8, 16, 12, 4, 12, 16, 8, 4},
        {4, 10, 28, 16, 8, 16, 28, 10, 4},
        {12, 14, 16, 20, 18, 20, 16, 14, 12},
        {8, 24, 18, 24, 20, 24, 18, 24, 8},
        {6, 16, 14, 18, 16, 18, 14, 16, 6},
        {4, 12, 16, 14, 12, 14, 16, 12, 4},
        {2, 6, 8, 6, 10, 6, 8, 6, 2},
        {4, 2, 8, 8, 4, 8, 8, 2, 4},
        {0, 2, 4, 4, -2, 4, 4, 2, 0},
        {0, -4, 0, 0, 0, 0, 0, -4, 0}
        
    };
    int jPosition[10][9] = {
        {14, 14, 12, 18, 16, 18, 12, 14, 14},
        {16, 20, 18, 24, 26, 24, 18, 20, 16},
        {12, 12, 12, 18, 18, 18, 12, 12, 12},
        {12, 18, 16, 22, 22, 22, 16, 18, 12},
        {12, 14, 12, 18, 18, 18, 12, 14, 12},
        {12, 16, 14, 20, 20, 20, 14, 16, 12},
        {6, 10, 8, 14, 14, 14, 8, 10, 6},
        {4, 8, 6, 14, 12, 14, 6, 8, 4},
        {8, 4, 8, 16, 8, 16, 8, 4, 8},
        {-2, 10, 6, 14, 12, 14, 6, 10, -2}
    };
    int zPosition[10][9] = {
        {0, 3, 6, 9, 12, 9, 6, 3, 0},
        {18, 36, 56, 80, 120, 80, 56, 36, 18},
        {14, 26, 42, 60, 80, 60, 42, 26, 14},
        {10, 20, 30, 34, 40, 34, 30, 20, 10},
        {6, 12, 18, 18, 20, 18, 18, 12, 6},
        {2, 0, 8, 0, 8, 0, 8, 0, 2},
        {0, 0, -2, 0, 4, 0, -2, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
    };
    if (p==3) {
        return mPosition[pos.x][pos.y];
        
    }
    if (p==4) {
        return jPosition[pos.x][pos.y];
        
    }
    if (p==5) {
        return pPosition[pos.x][pos.y];
        
    }if (p==6) {
        return zPosition[pos.x][pos.y];
    }
    return -1;
    
}
-(int)evalPieceControl{
    return 0;
}
-(int)evalPieceFlexible:(int)p{
    int pieceFlexible[] = {0, 1, 1, 13, 7, 7, 15};
    return pieceFlexible[p];
}
-(int)evalPieceProtect{
    return 0;
}
-(int)evalPieceFeature{
    return 0;
}
@end
