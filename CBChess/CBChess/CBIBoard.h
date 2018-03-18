//
//  CBIBoard.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCPiece.h"

#define BOARD_HEIGHT  8

#define BOARD_WIDTH  8


@interface CBIBoard : NSObject

@property(strong,nonatomic)NSMutableDictionary *pieceMap;

@property(strong,nonatomic)NSMutableArray*cells;


@property(assign,nonatomic)char player;


-(BOOL)isInsideWithLocation:(CBLocation *)location;

-(BOOL)IsEmpty:(CBLocation*)location;
-(BOOL)update:(CBCPiece *)piece;
-(CBCPiece *)getPieceWithLocation:(CBLocation *)location;

-(CBCPiece *)updatePiece:(NSString *)key newLocation:(CBLocation *)location;
-(BOOL)backPiece:(NSString *)key;
@end
