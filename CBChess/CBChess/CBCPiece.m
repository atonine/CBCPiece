//
//  CBCPiece.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCPiece.h"

@implementation CBCPiece

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithName:(NSString *)name location:(CBLocation *)location{
    self = [super init];
    self.key = name;
    self.color  = [name characterAtIndex:0];
    self.character = [name characterAtIndex:1];
    self.index = [name characterAtIndex:2];
    self.location = location;
    return self;
}

@end
