//
//  CBCSearchModel.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/27.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCAlpaBetaNode.h"
#import "CBCBoard.h"

@interface CBCSearchModel : NSObject

-(CBCAlpaBetaNode *)search:(CBCBoard *)board;
-(CBCAlpaBetaNode *)search2:(CBCBoard *)board;
@end
