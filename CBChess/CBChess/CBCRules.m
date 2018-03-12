//
//  CBCRules.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCRules.h"


@implementation CBCRules
+(NSArray *)getNextMoveWithPiece:(NSString *)piece location:(CBLocation *)loc board:(CBCBoard *)board{
    CBCRules *rules = [[CBCRules alloc]init];
    rules.board = board;
    rules.location = loc;
    rules.player = [piece characterAtIndex:0];
    switch ([piece characterAtIndex:1]) {
        case 'j':
            return [rules jRules];
        case 'm':
            return [rules mRules];
        case 'p':
            return [rules pRules];
        case 'x':
            return [rules xRules];
        case 's':
            return [rules sRules];
        case 'b':
            return [rules bRules];
        case 'z':
            return [rules zRules];
        default:
            return nil;
    }
}
-(NSArray *)mRules{
    NSMutableArray *moves = [NSMutableArray array];
//    NSArray *taget = @[@[@1,@(-2)],@[@2,@(-1)],@[@2,@1],@[@1,@2],@[@-1,@2],@[@-2,@1],@[@-2,@-1],@[@-1,@-2]];
//    NSArray *obstacle = @[@[@0,@-1],@[@1,@0],@[@1,@0]]
    int target[][2] = {{1,-2},{2,-1},{2,1},{1,2},{-1,2},{-2,1},{-2,-1},{-1,-2}};
    int obstacle [][2] = {{0,-1},{1,0},{1,0},{0,1},{0,1},{-1,0},{-1,0},{0,-1}};
    
    for (int i=0; i<8; i++) {
        CBLocation *eloc = [[CBLocation alloc]init];
        eloc.x = self.location.x + target[i][0];
        eloc.y = self.location.y + target[i][1];
        CBLocation *floc = [[CBLocation alloc]init];
        floc.x = self.location.x + obstacle[i][0];
        floc.y = self.location.y + obstacle[i][1];
        if (![self.board isInsideWithLocation:eloc])continue;
        if ([self.board IsEmpty:floc]) {
            if ([self.board IsEmpty:eloc]) {
                [moves addObject:eloc];
            }else if([self.board getPieceWithLocation:eloc].color!=self.player){
                [moves addObject:eloc];
            }
        }
        
    }
//    NSArray *target = @[1,2];
    return moves;
}

-(NSArray *)jRules{
    NSMutableArray *moves = [NSMutableArray array];
    int yOffset[] = {1,2,3,4,5,6,7,8};
    int xOffset[] = {1,2,3,4,5,6,7,8,9};
    for (int i = 0; i<8; i++){
        int offset = yOffset[i];
        
        CBLocation * rMove = [[CBLocation alloc]init];
        rMove.x = self.location.x;
        rMove.y = self.location.y+ offset;
        if ([self.board IsEmpty:rMove]) {
            [moves addObject:rMove ];
        }else if ([self.board isInsideWithLocation:rMove]&&[self.board getPieceWithLocation:rMove].color != self.player){
            [moves addObject:rMove];
            break;
        }else{
            break;
        }
            
    }
    for (int i = 0; i<8; i++){
        int offset = yOffset[i];
        
        CBLocation * lMove = [[CBLocation alloc]init];
        lMove.x = self.location.x;
        lMove.y = self.location.y- offset;
        if ([self.board IsEmpty:lMove]) {
            [moves addObject:lMove ];
        }else if ([self.board isInsideWithLocation:lMove]&&[self.board getPieceWithLocation:lMove].color != self.player){
            [moves addObject:lMove];
            break;
        }else{
            break;
        }
    }
    for (int i = 0; i<9; i++){
        int offset = xOffset[i];
        
        CBLocation * uMove = [[CBLocation alloc]init];
        uMove.x = self.location.x-offset;
        uMove.y = self.location.y;
        if ([self.board IsEmpty:uMove]) {
            [moves addObject:uMove ];
        }else if ([self.board isInsideWithLocation:uMove]&&[self.board getPieceWithLocation:uMove].color != self.player){
            [moves addObject:uMove];
            break;
        }else{
            break;
        }
    }
    for (int i = 0; i<9; i++){
        int offset = xOffset[i];
        
        CBLocation * dMove = [[CBLocation alloc]init];
        dMove.x = self.location.x+offset;
        dMove.y = self.location.y;
        if ([self.board IsEmpty:dMove]) {
            [moves addObject:dMove ];
        }else if ([self.board isInsideWithLocation:dMove]&&[self.board getPieceWithLocation:dMove].color != self.player){
            [moves addObject:dMove];
            break;
        }else{
            break;
        }
    }
    return moves;
}

-(NSArray *)pRules{
    NSMutableArray *moves = [NSMutableArray array];
    int yOffset[] = {1,2,3,4,5,6,7,8};
    int xOffset[] = {1,2,3,4,5,6,7,8,9};
    BOOL rr = NO;
    BOOL ll = NO;
    BOOL uu = NO;
    BOOL dd = NO;
    for (int i=0; i<8; i++) {
        int offset = yOffset[i];
        CBLocation * rMove = [[CBLocation alloc]init];
        rMove.x = self.location.x;
        rMove.y = self.location.y+ offset;
        if (![self.board isInsideWithLocation:rMove]) {
            break;
        }
        BOOL e = [self.board IsEmpty:rMove];
        if (!rr) {
            if (e) {
                [moves addObject:rMove];
            }else{
                rr = YES;
            }
            
        }else if(!e){
            if ([self.board getPieceWithLocation:rMove].color!=self.player) {
                [moves addObject:rMove];
                break;
            }
        }
        
    }
    
    
    for (int i=0; i<8; i++) {
        int offset = yOffset[i];
        CBLocation * lMove = [[CBLocation alloc]init];
        lMove.x = self.location.x;
        lMove.y = self.location.y - offset;
        if (![self.board isInsideWithLocation:lMove]) {
            break;
        }
        BOOL e = [self.board IsEmpty:lMove];
        if (!ll) {
            if (e) {
                [moves addObject:lMove];
            }else{
                ll = YES;
            }
            
        }else if(!e){
            if ([self.board getPieceWithLocation:lMove].color!=self.player) {
                [moves addObject:lMove];
                break;
            }
        }
        
    }
    for (int i=0; i<9; i++) {
        int offset = xOffset[i];
        CBLocation * uMove = [[CBLocation alloc]init];
        uMove.x = self.location.x - offset;
        uMove.y = self.location.y;
        if (![self.board isInsideWithLocation:uMove]) {
            break;
        }
        BOOL e = [self.board IsEmpty:uMove];
        if (!uu) {
            if (e) {
                [moves addObject:uMove];
            }else{
                uu = YES;
            }
            
        }else if(!e){
            if ([self.board getPieceWithLocation:uMove].color!=self.player) {
                [moves addObject:uMove];
                break;
            }
        }
        
    }
    for (int i=0; i<9; i++) {
        int offset = xOffset[i];
        CBLocation * dMove = [[CBLocation alloc]init];
        dMove.x = self.location.x + offset;
        dMove.y = self.location.y;
        if (![self.board isInsideWithLocation:dMove]) {
            break;
        }
        BOOL e = [self.board IsEmpty:dMove];
        if (!dd) {
            if (e) {
                [moves addObject:dMove];
            }else{
                dd = YES;
            }
            
        }else if(!e){
            if ([self.board getPieceWithLocation:dMove].color!=self.player) {
                [moves addObject:dMove];
                break;
            }
        }
        
    }
    return moves;
}
-(NSArray *)sRules{
    NSMutableArray *moves = [NSMutableArray array];
    int target [][2] = {{-1,-1},{1,1},{-1,1},{1,-1}};
    for (int i = 0; i<4; i++) {
        int *aTarget = target[i];
        CBLocation *eloc = [[CBLocation alloc]init];
        eloc.x = self.location.x + aTarget[0];
        eloc.y = self.location.y + aTarget[1];
        if (![self.board isInsideWithLocation:eloc]||((eloc.x>2 ||eloc.y < 3||eloc.y>5)&&self.player=='b')||((eloc.y<7||eloc.y<3||eloc.y>5)&&self.player=='r')) {
            continue;
        }
        if ([self.board IsEmpty:eloc]) {
            [moves addObject:eloc];
        }else if ([self.board getPieceWithLocation:eloc].color!=self.player){
            [moves addObject:eloc];
        }
        
    }
    return moves;
}
-(NSArray *)xRules{
    NSMutableArray *moves = [NSMutableArray array];
    int target[][2] = {{-2,-2},{2,-2},{-2,2},{2,2}};
    int obstacle [][2] = {{-1,-1},{1,-1},{-1,1},{1,1}};
    
    for (int i=0; i<4; i++) {
        CBLocation *eloc = [[CBLocation alloc]init];
        eloc.x = self.location.x + target[i][0];
        eloc.y = self.location.y + target[i][1];
        CBLocation *floc = [[CBLocation alloc]init];
        floc.x = self.location.x + obstacle[i][0];
        floc.y = self.location.y + obstacle[i][1];
        if (![self.board isInsideWithLocation:eloc]||(eloc.x>4&&self.player == 'b')||(eloc.x<5&&self.player == 'r'))continue;
        if ([self.board IsEmpty:floc]) {
            if ([self.board IsEmpty:eloc]) {
                [moves addObject:eloc];
            }else if([self.board getPieceWithLocation:eloc].color!=self.player){
                [moves addObject:eloc];
            }
        }
        
    }
    //    NSArray *target = @[1,2];
    return moves;
}
//boss (将 帅)
-(NSArray *)bRules{
    NSMutableArray *moves = [NSMutableArray array];
    int target [][2] = {{0,1},{0,-1},{1,0},{-1,0}};
    for (int i=0; i<4; i++) {
        int *aTarget = target[i];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + aTarget[0];
        e.y = self.location.y + aTarget[1];
        if (![self.board isInsideWithLocation:e]||((e.x>2||e.y<3||e.y>5)&&self.player ==  'b')||((e.x>7||e.y<3||e.y>5)&&self.player!='r')) {
            continue;
        }
        if ([self.board IsEmpty:e]) {
            [moves addObject:e];
        }else if([self.board getPieceWithLocation:e].color!= self.player){
            [moves addObject:e];
        }
    }
    BOOL flag = YES;
    CBCPiece * oppb = self.board.pieceMap[@"bb0"];
    CBCPiece * rb = self.board.pieceMap[@"rb0"];
    CBLocation *oppoBoss = (self.player=='r')? oppb.location :rb.location;
    if (oppoBoss.y == self.location.y) {
        for (int i = [self min:oppoBoss.x with:self.location.x]+1; i<[self max:oppoBoss.x with:self.location.x]; i++) {
            flag = NO;
            break;
        }
        if (flag) {
            [moves addObject:oppoBoss];
        }
    }
    return moves;
}
-(NSArray *)zRules{
    NSMutableArray *moves =  [NSMutableArray array];
    int targetU[][2] ={{0,1},{0,-1},{-1,0}};
    int targetD[][2] ={{0,1},{0,-1},{1,0}};
    if (self.player == 'r') {
        if (self.location.x>4) {
            CBLocation *e = [[CBLocation alloc]init];
            e.x = self.location.x -1;
            e.y = self.location.y;
            if ([self.board IsEmpty:e]) {
                [moves addObject:e];
                
            }
            else if([self.board getPieceWithLocation:e].color!=self.player){
                [moves addObject:e];
            }
        }
        else{
            for (int i = 0; i<3; i++) {
                int *aTarget = targetD[i];
                CBLocation *e = [[CBLocation alloc]init];
                e.x = self.location.x +aTarget[0];
                e.y = self.location.y +aTarget[1];
                if (![self.board isInsideWithLocation:e]) {
                    continue;
                }if ([self.board IsEmpty:e]) {
                    [moves addObject:e];
                }else if([self.board getPieceWithLocation:e].color!=self.player){
                    [moves addObject:e];
                }
            }
        }
    }
    if (self.player == 'b') {
        if (self.location.x<5) {
            CBLocation *e = [[CBLocation alloc]init];
            e.x = self.location.x +1;
            e.y = self.location.y;
            if ([self.board IsEmpty:e]) {
                [moves addObject:e];
                
            }
            else if([self.board getPieceWithLocation:e].color!=self.player){
                [moves addObject:e];
            }
        }
        else{
            for (int i = 0; i<3; i++) {
                int *aTarget = targetU[i];
                CBLocation *e = [[CBLocation alloc]init];
                e.x = self.location.x +aTarget[0];
                e.y = self.location.y +aTarget[1];
                if (![self.board isInsideWithLocation:e]) {
                    continue;
                }if ([self.board IsEmpty:e]) {
                    [moves addObject:e];
                }else if([self.board getPieceWithLocation:e].color!=self.player){
                    [moves addObject:e];
                }
            }
        }
    }
    return moves;
}

-(int)min:(int)i with:(int)j{
    return (i<=j)?i:j;
}
-(int)max:(int)i with:(int)j{
    return (i>=j)?i:j;
}

@end
