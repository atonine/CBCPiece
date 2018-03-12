//
//  CBCEvalModel.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/21.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCBoard.h"

@interface CBCEvalModel : NSObject


-(int)eval:(CBCBoard *)board player:(char)player;
@end
