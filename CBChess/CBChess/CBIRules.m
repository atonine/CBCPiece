//
//  CBIRules.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBIRules.h"

@implementation CBIRules


+(NSArray *)getNextMoveWithPiece:(NSString *)piece location:(CBLocation *)loc board:(CBIBoard *)board{
    CBIRules *rules = [[CBIRules alloc]init];
    rules.board = board;
    rules.location = loc;
    rules.player = [piece characterAtIndex:0];
    switch ([piece characterAtIndex:1]) {
        case 'k':
        return [rules kRules];
        case 'q':
        return [rules qRules];
        case 't':
        return [rules tRules];
        case 'n':
        return [rules nRules];
        case 'r':
        return [rules rRules];
        case 'h':
        return [rules hRules];
        default:
        return nil;
    }
}
-(NSArray *)kRules{
    int target[][2] = {{1,1},{1,-1},{-1,1},{-1,-1},{1,0},{0,1},{-1,0},{0,-1}};
    NSMutableArray *moves = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + target[i][0];
        e.x = self.location.y + target[i][1];
        if (![self.board isInsideWithLocation:e]) {
            continue;
        }else if([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color!=self.player){
            [moves addObject:e];
        }else if ([self.board IsEmpty:e]){
            [moves addObject:e];
        }
    }
    
    
    
    return moves;
}
-(NSArray *)qRules{
    int rigtDown[][2] = {{1,1},{2,2},{3,3},{4,4},{5,5},{6,6},{7,7}};
    int rigtUp[][2] = {{-1,1},{-2,2},{-3,3},{-4,4},{-5,5},{-6,6},{-7,7}};
    int leftDown[][2] = {{1,-1},{2,-2},{3,-3},{4,-4},{5,-5},{6,-6},{7,-7}};
    int leftUp[][2] = {{-1,-1},{-2,-2},{-3,-3},{-4,-4},{-5,-5},{-6,-6},{-7,-7}};
    int left[][2] = {{0,-1},{0,-2},{0,-3},{0,-4},{0,-5},{0,-6},{0,-7}};
    int right[][2] = {{0,1},{0,2},{0,3},{0,4},{0,5},{0,6},{0,7}};
    int down[][2] = {{1,0},{2,0},{3,0},{4,0},{5,0},{6,0},{7,0}};
    int up[][2] = {{-1,0},{-2,0},{-3,0},{-4,0},{-5,0},{-6,0},{-7,0}};
    NSMutableArray *moves = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        
        int rdTargetX = rigtDown[i][0];
        int rdTargetY = rigtDown[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int rdTargetX = leftDown[i][0];
        int rdTargetY = leftDown[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
        
    }
    for (int i = 0; i < 7; i++) {
        
        int rdTargetX = rigtUp[i][0];
        int rdTargetY = rigtUp[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = leftUp[i][0];
        int luTargetY = leftUp[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = left[i][0];
        int luTargetY = left[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = right[i][0];
        int luTargetY = right[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = down[i][0];
        int luTargetY = down[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = up[i][0];
        int luTargetY = up[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    return moves;
}
-(NSArray *)hRules{
    CBLocation *loc = [[CBLocation alloc]init];
    loc.x = 5;
    loc.y = 3;
    CBCPiece *piece = [self.board getPieceWithLocation:loc];
    NSLog(@"%@",piece.key);
    int rigtDown[][2] = {{1,1},{2,2},{3,3},{4,4},{5,5},{6,6},{7,7}};
    int rigtUp[][2] = {{-1,1},{-2,2},{-3,3},{-4,4},{-5,5},{-6,6},{-7,7}};
    int leftDown[][2] = {{1,-1},{2,-2},{3,-3},{4,-4},{5,-5},{6,-6},{7,-7}};
    int leftUp[][2] = {{-1,-1},{-2,-2},{-3,-3},{-4,-4},{-5,-5},{-6,-6},{-7,-7}};
   // int leftUpTarget[][2] = {{1,1},{2,2},{3,3},{4,4},{5,5},{6,6},{7,7}};
    NSMutableArray *moves = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
     
        int rdTargetX = rigtDown[i][0];
        int rdTargetY = rigtDown[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int rdTargetX = leftDown[i][0];
        int rdTargetY = leftDown[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
        
        }
    for (int i = 0; i < 7; i++) {
        
        int rdTargetX = rigtUp[i][0];
        int rdTargetY = rigtUp[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + rdTargetX;
        e.y = self.location.y + rdTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
        }else{
            break;
        }
    }
    for (int i = 0; i < 7; i++) {
        
        int luTargetX = leftUp[i][0];
        int luTargetY = leftUp[i][1];
        CBLocation *e = [[CBLocation alloc]init];
        e.x = self.location.x + luTargetX;
        e.y = self.location.y + luTargetY;
        BOOL isNil = [self.board IsEmpty:e];
        if (isNil) {
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
        }else if ([self.board isInsideWithLocation:e]&&[self.board getPieceWithLocation:e].color != self.player){
            CBCPiece *pi = [self.board getPieceWithLocation:e];
            NSLog(@"%@",pi.key);
            [moves addObject:e];
            break;
            
            
        }else{
            break;
        }
    }
    return moves;
}
-(NSArray *)nRules{
    NSMutableArray *moves = [NSMutableArray array];
    //    NSArray *taget = @[@[@1,@(-2)],@[@2,@(-1)],@[@2,@1],@[@1,@2],@[@-1,@2],@[@-2,@1],@[@-2,@-1],@[@-1,@-2]];
    //    NSArray *obstacle = @[@[@0,@-1],@[@1,@0],@[@1,@0]]
    int target[][2] = {{1,-2},{2,-1},{2,1},{1,2},{-1,2},{-2,1},{-2,-1},{-1,-2}};
   
    
    for (int i=0; i<8; i++) {
        CBLocation *eloc = [[CBLocation alloc]init];
        eloc.x = self.location.x + target[i][0];
        eloc.y = self.location.y + target[i][1];
       
        if (![self.board isInsideWithLocation:eloc])continue;
       
        if ([self.board IsEmpty:eloc]) {
            [moves addObject:eloc];
        }else if([self.board getPieceWithLocation:eloc].color!=self.player){
            [moves addObject:eloc];
        }
        
        
    }
    //    NSArray *target = @[1,2];
    return moves;
}

-(NSArray *)rRules{
    NSMutableArray *moves = [NSMutableArray array];
    int yOffset[] = {1,2,3,4,5,6,7};
    int xOffset[] = {1,2,3,4,5,6,7};
    BOOL rr = NO;
    BOOL ll = NO;
    BOOL uu = NO;
    BOOL dd = NO;
    for (int i=0; i<7; i++) {
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
    
    
    for (int i=0; i<7; i++) {
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
    for (int i=0; i<7; i++) {
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
    for (int i=0; i<7; i++) {
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


//兵的规则
-(NSArray *)tRules{
    NSMutableArray *moves = [NSMutableArray array];
    if(self.player == 'b'){
        CBLocation *e1 = [[CBLocation alloc]init];
        e1.x = self.location.x + 1;
        e1.y = self.location.y;
        if([self.board IsEmpty:e1]){
            [moves addObject:e1];
        }
        CBLocation *e2 = [[CBLocation alloc]init];
        e2.x = self.location.x+1;
        e2.y = self.location.y+1;
        CBCPiece *pi = [self.board getPieceWithLocation:e2];
        if((pi.color!=self.player)&&![pi.key isEqualToString:@"nil"]&&[self.board isInsideWithLocation:e2]){
            [moves addObject:e2];
        }
        CBLocation *e3 = [[CBLocation alloc]init];
        e3.x = self.location.x+1;
        e3.y = self.location.y-1;
        CBCPiece *pi2 = [self.board getPieceWithLocation:e3];
        if((pi2.color!=self.player)&&![pi2.key isEqualToString:@"nil"]&&[self.board isInsideWithLocation:e3]){
            [moves addObject:e3];
        }
        if(self.location.x==1){
            CBLocation *e = [[CBLocation alloc]init];
            e.x = self.location.x + 2;
            e.y = self.location.y;
            if([self.board IsEmpty:e]){
                [moves addObject:e];
            }
        }
       
    }
    if(self.player == 'w'){
        CBLocation *e1 = [[CBLocation alloc]init];
        e1.x = self.location.x - 1;
        e1.y = self.location.y;
        if([self.board IsEmpty:e1]){
            [moves addObject:e1];
        }
         CBLocation *e2 = [[CBLocation alloc]init];
        e2.x = self.location.x-1;
        e2.y = self.location.y+1;
        CBCPiece *pi = [self.board getPieceWithLocation:e2];
        if((pi.color!=self.player)&&![pi.key isEqualToString:@"nil"]&&[self.board isInsideWithLocation:e2]){
            [moves addObject:e2];
        }
        CBLocation *e3 = [[CBLocation alloc]init];
        e3.x = self.location.x-1;
        e3.y = self.location.y-1;
        CBCPiece *pi2 = [self.board getPieceWithLocation:e3];
        if((pi2.color!=self.player)&&![pi2.key isEqualToString:@"nil"]&&[self.board isInsideWithLocation:e3]){
            [moves addObject:e3];
        }
        if(self.location.x==6){
            CBLocation *e = [[CBLocation alloc]init];
            e.x = self.location.x - 2;
            e.y = self.location.y;
            if([self.board IsEmpty:e]){
                [moves addObject:e];
            }
        }
        
    }
    return moves;
}

@end
