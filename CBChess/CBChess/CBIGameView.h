//
//  CBIGameView.h
//  CBChess
//
//  Created by 于洪志 on 2018/3/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBIGameControl.h"

@interface CBIGameView : UIImageView


-(instancetype)initWithBoard:(CBIBoard *)board frame:(CGRect)frame;

@end
