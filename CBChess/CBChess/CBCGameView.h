//
//  CBCGameView.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/4.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCGameControl.h"

@interface CBCGameView : UIImageView

-(void)movePieceFromAI:(NSString *)pieceKey location:(CBLocation *)to;

-(instancetype)initWithBoard:(CBCBoard *)board;

@end
