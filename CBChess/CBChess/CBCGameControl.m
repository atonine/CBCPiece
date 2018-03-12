//
//  CBCGameControl.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/4.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCGameControl.h"

#import "CBCSearchModel.h"
#import "CBCAlpaBetaNode.h"

@implementation CBCGameControl

static CBCGameControl *_instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(instancetype)control{
    return [[self alloc]init];
}


-(NSDictionary *)setPieces{
    NSMutableDictionary *pieces = [NSMutableDictionary dictionary];
    CBCPiece *bj0 = [self setPieceWithName:@"bj0" x:0 y:0];
    [pieces setValue:bj0 forKey:@"bj0"];
    CBCPiece *bm0= [self setPieceWithName:@"bm0" x:0 y:1];
    [pieces setValue:bm0 forKey:@"bm0"];
    CBCPiece *bx0= [self setPieceWithName:@"bx0" x:0 y:2];
    [pieces setValue:bx0 forKey:@"bx0"];
    CBCPiece *bs0= [self setPieceWithName:@"bs0" x:0 y:3];
    [pieces setValue:bs0 forKey:@"bs0"];
    CBCPiece *bb0= [self setPieceWithName:@"bb0" x:0 y:4];
    [pieces setValue:bb0 forKey:@"bb0"];
    CBCPiece *bs1= [self setPieceWithName:@"bs1" x:0 y:5];
    [pieces setValue:bs1 forKey:@"bs1"];
    CBCPiece *bx1= [self setPieceWithName:@"bx1" x:0 y:6];
    [pieces setValue:bx1 forKey:@"bx1"];
    CBCPiece *bm1= [self setPieceWithName:@"bm1" x:0 y:7];
    [pieces setValue:bm1 forKey:@"bm1"];
    CBCPiece *bj1= [self setPieceWithName:@"bj1" x:0 y:8];
    [pieces setValue:bj1 forKey:@"bj1"];
    
    CBCPiece *bp0= [self setPieceWithName:@"bp0" x:2 y:1];
    
    [pieces setValue:bp0 forKey:@"bp0"];
    CBCPiece *bp1= [self setPieceWithName:@"bp1" x:2 y:7];
    [pieces setValue:bp1 forKey:@"bp1"];
    
    CBCPiece *bz0= [self setPieceWithName:@"bz0" x:3 y:0];
    
    [pieces setValue:bz0 forKey:@"bz0"];
    
    
    CBCPiece *bz1= [self setPieceWithName:@"bz1" x:3 y:2];
    
    [pieces setValue:bz1 forKey:@"bz1"];
    
    CBCPiece *bz2= [self setPieceWithName:@"bz2" x:3 y:4];
    
    [pieces setValue:bz2 forKey:@"bz2"];
    CBCPiece *bz3= [self setPieceWithName:@"bz3" x:3 y:6];
    
    [pieces setValue:bz3 forKey:@"bz3"];
    CBCPiece *bz4= [self setPieceWithName:@"bz3" x:3 y:8];
    
    [pieces setValue:bz4 forKey:@"bz4"];
    
    
    //红方
    CBCPiece *rj0 = [self setPieceWithName:@"rj0" x:9 y:0];
    [pieces setValue:rj0 forKey:@"rj0"];
    CBCPiece *rm0= [self setPieceWithName:@"rm0" x:9 y:1];
    [pieces setValue:rm0 forKey:@"rm0"];
    CBCPiece *rx0= [self setPieceWithName:@"rx0" x:9 y:2];
    [pieces setValue:rx0 forKey:@"rx0"];
    CBCPiece *rs0= [self setPieceWithName:@"rs0" x:9 y:3];
    [pieces setValue:rs0 forKey:@"rs0"];
    CBCPiece *rb0= [self setPieceWithName:@"rb0" x:9 y:4];
    [pieces setValue:rb0 forKey:@"rb0"];
    CBCPiece *rs1= [self setPieceWithName:@"rs1" x:9 y:5];
    [pieces setValue:rs1 forKey:@"rs1"];
    CBCPiece *rx1= [self setPieceWithName:@"bx1" x:9 y:6];
    [pieces setValue:rx1 forKey:@"rx1"];
    CBCPiece *rm1= [self setPieceWithName:@"rm1" x:9 y:7];
    [pieces setValue:rm1 forKey:@"rm1"];
    CBCPiece *rj1= [self setPieceWithName:@"rj1" x:9 y:8];
    [pieces setValue:rj1 forKey:@"rj1"];
    
    CBCPiece *rp0= [self setPieceWithName:@"rp0" x:7 y:1];
    
    [pieces setValue:rp0 forKey:@"rp0"];
    CBCPiece *rp1= [self setPieceWithName:@"rp1" x:7 y:7];
    [pieces setValue:rp1 forKey:@"rp1"];
    
    CBCPiece *rz0= [self setPieceWithName:@"rz0" x:6 y:0];
    
    [pieces setValue:rz0 forKey:@"rz0"];
    
    
    CBCPiece *rz1= [self setPieceWithName:@"rz1" x:6 y:2];
    
    [pieces setValue:rz1 forKey:@"rz1"];
    
    CBCPiece *rz2= [self setPieceWithName:@"rz2" x:6 y:4];
    
    [pieces setValue:rz2 forKey:@"rz2"];
    CBCPiece *rz3= [self setPieceWithName:@"rz3" x:6 y:6];
    
    [pieces setValue:rz3 forKey:@"rz3"];
    CBCPiece *rz4= [self setPieceWithName:@"rz3" x:6 y:8];
    
    [pieces setValue:rz4 forKey:@"rz4"];
    
    
    return pieces;
}

-(CBCBoard *)setBoard{
    CBCBoard *board = [[CBCBoard alloc]init];
  //  board.player = 'r';
    NSDictionary *pieces = [self setPieces];
    board.pieceMap = [NSMutableDictionary dictionaryWithDictionary:pieces];
    NSArray *keys = [pieces allKeys];
    for (NSString *key in keys) {
        [board update:pieces[key]];
    }
    return  board;
    
}
-(CBCBoard *)startChess{
    [self setPieces];
    return [self setBoard];
}
//-(CBCBoard* )moveChess:(NSString *)key location:(CBLocation *)loc{
//    CBCBoard *board = []
//    [board updatePiece:key newLocation:loc];
//}
//-(void)responseMoveChess:(CBCBoard *)board GameView:(CBCGameView *)view{
//    CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
//    CBCAlpaBetaNode *result =  [searchModel search:board];
//    [view movePieceFromAI:result.piece location:result.to];
//
//    [board updatePiece:result.piece newLocation:result.to];
//
//
//}
-(CBCPiece *)setPieceWithName:(NSString *)name x:(int)x y:(int)y{
    CBLocation * loc = [[CBLocation alloc]init];
    loc.x = x;
    loc.y = y;
    CBCPiece *chess  = [[CBCPiece alloc]initWithName:name location:loc];
    return chess;
}

-(char)hasWin:(CBCBoard *)board{
    if (board.pieceMap[@"bb0"]==nil) {
        return 'r';
    }else if(board.pieceMap[@"rb0"]==nil){
        return 'b';
    }else{
        return 'x';
    }
}
@end
