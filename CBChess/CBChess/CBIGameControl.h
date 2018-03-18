//
//  CBIGameControl.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBIRules.h"

@interface CBIGameControl : NSObject
+(instancetype)control;

-(NSDictionary *)setPieces;

-(CBIBoard*)startChess;

-(char)hasWin:(CBIBoard *)board;

-(CBIBoard *)setBoard;

-(CBIBoard *)moveChess:(NSString *)key location:(CBLocation *)loc;

@end
