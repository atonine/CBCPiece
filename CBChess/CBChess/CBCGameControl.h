//
//  CBCGameControl.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/4.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCRules.h"
//#import "CBCGameView.h"

@interface CBCGameControl : NSObject

+(instancetype)control;

-(NSDictionary *)setPieces;

-(CBCBoard*)startChess;

-(char)hasWin:(CBCBoard *)board;

-(CBCBoard *)setBoard;


-(CBCBoard *)moveChess:(NSString *)key location:(CBLocation *)loc;

//-(void)responseMoveChess:(CBCBoard *)board GameView:(CBCGameView *)view;


@end
