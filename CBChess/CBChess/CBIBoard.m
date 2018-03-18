//
//  CBIBoard.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBIBoard.h"

@implementation CBIBoard

-(instancetype)init{
    self = [super init];
    if (self) {
        _player = 'w';
    }
    return self;
}
-(CBCPiece *)updatePiece:(NSString *)key newLocation:(CBLocation *)location{
    CBCPiece *orig = self.pieceMap[key];
    CBCPiece *newLocPiece = [self getPieceWithLocation:location];
    if (newLocPiece!=nil||![newLocPiece.key isEqualToString: @"nil"]) {
        [self.pieceMap removeObjectForKey:newLocPiece.key];
    }
    CBLocation *origLoc = orig.location;
    CBCPiece *pie = [[CBCPiece alloc]init];
    pie.key = @"nil";
    pie.location.x = -1;
    pie.location.y = -1;
    self.cells[origLoc.x][origLoc.y] = pie;
    self.cells[location.x][location.y] = orig;
    orig.location = location;
    self.pieceMap[key] = orig;
    self.player = (self.player == 'w') ? 'b' : 'w';
    return  newLocPiece;
    
}
-(NSMutableArray *)cells{
    if (_cells==nil) {
        _cells = [NSMutableArray arrayWithCapacity:11];
        for (int i = 0; i<=8; i++) {
            NSMutableArray * arr = [NSMutableArray arrayWithCapacity:11];
            for (int i = 0; i<=8; i++) {
                CBCPiece *pie = [[CBCPiece alloc]init];
                pie.key = @"nil";
                pie.location.x = -1;
                pie.location.y = -1;
                [arr addObject:pie];
            }
            [_cells addObject:arr];
        }
        
    }
    return _cells;
}
-(CBCPiece *)getPieceWithLocation:(CBLocation *)location{
    int x = location.x;
    int y = location.y;
    
    return self.cells[x][y];
}

-(BOOL)isInsideWithLocation:(CBLocation *)location{
    return !(location.x<0||location.x>=BOARD_HEIGHT||location.y<0||location.y>=BOARD_WIDTH);
}
-(BOOL)IsEmpty:(CBLocation *)location{
    int x = location.x;
    int y = location.y;
    CBCPiece *piece = [[CBCPiece alloc]init];
    if (x<0||y<0||x>=BOARD_HEIGHT||y>=BOARD_WIDTH) {
        return false;
    }else{
        piece = self.cells[x][y];
    }
    
    BOOL isNil = ([piece.key isEqualToString: @"nil"]||piece == nil);
    return ([self isInsideWithLocation:location]&&isNil);
}

-(BOOL)update:(CBCPiece *)piece{
    CBLocation *loc = piece.location;
    if (![self isInsideWithLocation:loc]) {
        return false ;
    }else{
        int x = loc.x;
        int y = loc.y;
        self.cells[x][y] = piece;
        return true;
    }
}
-(BOOL)backPiece:(NSString *)key{
    CBCPiece *piece = self.pieceMap[key];
    CBLocation *origPos = piece.location;
    self.cells[origPos.x][origPos.y] = piece;
    return true;
}

@end
