//
//  CBCPiece.h
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBLocation.h"

@interface CBCPiece : UIView


/**
 <#注释#>
 */
@property (nonatomic,strong) NSString *key;

/**
 <#注释#>
 */
@property (nonatomic,assign) char color;

/**
 <#注释#>
 */
@property (nonatomic,assign) char character;
/**
 <#注释#>
 */
@property (nonatomic,assign) char index;


/**
 <#注释#>
 */
@property (nonatomic,strong) CBLocation *location;


-(instancetype)initWithName:(NSString *)name location:(CBLocation*)location;

@end
