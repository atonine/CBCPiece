//
//  CBIGameControl.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBIGameControl.h"

@implementation CBIGameControl

static CBIGameControl *_instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

-(NSDictionary *)setPieces{
     NSMutableDictionary *pieces = [NSMutableDictionary dictionary];
    CBCPiece *br0 = [self setPieceWithName:@"br0" x:0 y:0];
    [pieces setObject:br0 forKey:@"br0"];
    CBCPiece *bn0 = [self setPieceWithName:@"bn0" x:0 y:1];
    [pieces setObject:bn0 forKey:@"bn0"];
    CBCPiece *bh0 = [self setPieceWithName:@"bh0" x:0 y:2];
    [pieces setObject:bh0 forKey:@"bh0"];
    CBCPiece *bq0 = [self setPieceWithName:@"bq0" x:0 y:3];
    [pieces setObject:bq0 forKey:@"bq0"];
    CBCPiece *bk0 = [self setPieceWithName:@"bk0" x:0 y:4];
    [pieces setObject:bk0 forKey:@"bk0"];
    CBCPiece *bh1 = [self setPieceWithName:@"bh1" x:0 y:5];
    [pieces setObject:bh1 forKey:@"bh1"];
    CBCPiece *bn1 = [self setPieceWithName:@"bn1" x:0 y:6];
    [pieces setObject:bn1 forKey:@"bn1"];
    CBCPiece *br1 = [self setPieceWithName:@"br1" x:0 y:7];
    [pieces setObject:br1 forKey:@"br1"];
    
    
    CBCPiece *bt0 = [self setPieceWithName:@"bh0" x:1 y:0];
    [pieces setObject:bt0 forKey:@"bt0"];
    CBCPiece *bt1 = [self setPieceWithName:@"bh0" x:1 y:1];
    [pieces setObject:bt1 forKey:@"bt1"];
    CBCPiece *bt2 = [self setPieceWithName:@"bh0" x:1 y:2];
    [pieces setObject:bt2 forKey:@"bt2"];
    CBCPiece *bt3 = [self setPieceWithName:@"bh0" x:1 y:3];
    [pieces setObject:bt3 forKey:@"bt3"];
    CBCPiece *bt4 = [self setPieceWithName:@"bh0" x:1 y:4];
    [pieces setObject:bt4 forKey:@"bt4"];
    CBCPiece *bt5 = [self setPieceWithName:@"bh0" x:1 y:5];
    [pieces setObject:bt5 forKey:@"bt5"];
    CBCPiece *bt6 = [self setPieceWithName:@"bh0" x:1 y:6];
    [pieces setObject:bt6 forKey:@"bt6"];
    CBCPiece *bt7 = [self setPieceWithName:@"bh0" x:1 y:7];
    [pieces setObject:bt7 forKey:@"bt7"];
    
  
    CBCPiece *wr0 = [self setPieceWithName:@"wr0" x:7 y:0];
    [pieces setObject:wr0 forKey:@"wr0"];
    CBCPiece *wn0 = [self setPieceWithName:@"wn0" x:7 y:1];
    [pieces setObject:wn0 forKey:@"wn0"];
    CBCPiece *wh0 = [self setPieceWithName:@"wh0" x:7 y:2];
    [pieces setObject:wh0 forKey:@"wh0"];
    CBCPiece *wq0 = [self setPieceWithName:@"wq0" x:7 y:3];
    [pieces setObject:wq0 forKey:@"wq0"];
    CBCPiece *wk0 = [self setPieceWithName:@"wk0" x:7 y:4];
    [pieces setObject:wk0 forKey:@"wk0"];
    CBCPiece *wh1 = [self setPieceWithName:@"wh1" x:7 y:5];
    [pieces setObject:wh1 forKey:@"wh1"];
    CBCPiece *wn1 = [self setPieceWithName:@"wn1" x:7 y:6];
    [pieces setObject:wn1 forKey:@"wn1"];
    CBCPiece *wr1 = [self setPieceWithName:@"wr1" x:7 y:7];
    [pieces setObject:wr1 forKey:@"wr1"];
    
    
    CBCPiece *wt0 = [self setPieceWithName:@"wt0" x:6 y:0];
    [pieces setObject:wt0 forKey:@"wt0"];
    CBCPiece *wt1 = [self setPieceWithName:@"wt1" x:6 y:1];
    [pieces setObject:wt1 forKey:@"wt1"];
    CBCPiece *wt2 = [self setPieceWithName:@"wt2" x:6 y:2];
    [pieces setObject:wt2 forKey:@"wt2"];
    CBCPiece *wt3 = [self setPieceWithName:@"wt3" x:6 y:3];
    [pieces setObject:wt3 forKey:@"wt3"];
    CBCPiece *wt4 = [self setPieceWithName:@"wt4" x:6 y:4];
    [pieces setObject:wt4 forKey:@"wt4"];
    CBCPiece *wt5 = [self setPieceWithName:@"wt5" x:6 y:5];
    [pieces setObject:wt5 forKey:@"wt5"];
    CBCPiece *wt6 = [self setPieceWithName:@"wt6" x:6 y:6];
    [pieces setObject:wt6 forKey:@"wt6"];
    CBCPiece *wt7 = [self setPieceWithName:@"wt7" x:6 y:7];
    [pieces setObject:wt7 forKey:@"wt7"];
    return pieces;
}
-(CBIBoard *)setBoard{
    CBIBoard *board = [[CBIBoard alloc]init];
    //  board.player = 'r';
    NSDictionary *pieces = [self setPieces];
    board.pieceMap = [NSMutableDictionary dictionaryWithDictionary:pieces];
    NSArray *keys = [pieces allKeys];
    for (NSString *key in keys) {
        [board update:pieces[key]];
    }
    return  board;
}

-(CBCPiece *)setPieceWithName:(NSString *)name x:(int)x y:(int)y{
    CBLocation * loc = [[CBLocation alloc]init];
    loc.x = x;
    loc.y = y;
    CBCPiece *chess  = [[CBCPiece alloc]initWithName:name location:loc];
    return chess;
}
-(char)hasWin:(CBIBoard *)board{
    CBCPiece *bb = board.pieceMap[@"bk0"];
    CBCPiece *rb = board.pieceMap[@"wk0"];
    if (bb==nil||[bb.key isEqualToString:@"nil"]) {
        return 'w';
    }else if(rb==nil||[rb.key isEqualToString:@"nil"]){
        return 'b';
    }else{
        return 'x';
    }
}
@end
