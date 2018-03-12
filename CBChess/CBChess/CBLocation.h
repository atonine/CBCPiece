//
//  CBLocation.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBLocation : NSObject

/**
 <#注释#>
 */
@property (nonatomic,assign) int x;

/**
 <#注释#>
 */
@property (nonatomic,assign) int y;

-(instancetype)initWithArray:(NSArray *)array;

@end
