//
//  CBISearchModel.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/19.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCAlpaBetaNode.h"


@interface CBISearchModel : NSObject

-(CBCAlpaBetaNode *)search2:(CBIBoard *)board;

@end
