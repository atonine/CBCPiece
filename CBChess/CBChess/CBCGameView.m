//
//  CBCGameView.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/4.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCGameView.h"
#import "CBCChessView.h"
#import "CBCSearchModel.h"
static int SY_COE =41,SX_COE = 41;

static int SY_OFFSET =2.5,SX_OFFSET = 2.5;

@interface CBCGameView()

@property(nonatomic ,strong)CBCBoard *board;
@property(nonatomic, strong)CBCChessView *pieceView;

@property(nonatomic ,strong)CBCGameControl *control;

/**
 key
 */
@property (nonatomic,strong) NSString *selectedKey;

@property (nonatomic,strong)NSMutableDictionary * pieceObject;

@end

@implementation CBCGameView

-(void)setControl:(CBCGameControl *)control{
    _control = control;
}

-(void)setWithBoard:(CBCBoard *)board{
    
        self.pieceObject = [NSMutableDictionary dictionary];
        self.userInteractionEnabled = YES;
        self.board = board;
        NSDictionary *dic = board.pieceMap;
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            CBCPiece *piece =  dic[key];
            CBLocation *loc = piece.location;
            CBLocation*sloc = [self modelToViewConverter:loc];
            CBCChessView *chessVeiw = [[CBCChessView alloc]initWithFrame:CGRectMake(sloc.x, sloc.y, 41, 41)];
            chessVeiw.userInteractionEnabled = YES;
            chessVeiw.key = key;
            NSString *imageName = [NSString stringWithFormat:@"%@.png",[key substringWithRange:NSMakeRange(0, 2)]];
            [chessVeiw setImage:[UIImage imageNamed:imageName]];
            [self.pieceObject setObject:chessVeiw forKey:key];
            [self addSubview:chessVeiw];
        }
  
}

-(CBLocation *)modelToViewConverter:(CBLocation *)loc{
    CBLocation *sloc = [[CBLocation alloc]init];
    sloc.y = loc.x * SX_COE+SX_OFFSET-10;
    sloc.x = loc.y * SY_COE +SY_OFFSET-15;
    return sloc;
}
-(CBLocation *)viewToModelConverter:(CBLocation *)sloc{
    CBLocation *loc = [[CBLocation alloc]init];
    int y = (sloc.x -SX_OFFSET+10)/SX_COE;
    int x = (sloc.y -SY_OFFSET+15)/SY_COE;
    loc.x = x;
    loc.y = y;
    return loc;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self run];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *touchView = [touch view];
    
    if ([touchView isKindOfClass:[CBCChessView class]]) {
        CBCChessView *view = (CBCChessView *)touchView;
        CBCPiece *piece = self.board.pieceMap[view.key];
        NSLog(@"%zd,%zd,%c",piece.location.x,piece.location.y,self.board.player);
        if (self.selectedKey==nil) {
            self.selectedKey = view.key;
            
        }else if([view.key isEqualToString: self.selectedKey]&&[self.selectedKey characterAtIndex:0]!=self.board.player){
            return;
        }else if([view.key characterAtIndex:0]==self.board.player){
            self.selectedKey = view.key;
        }
        else if(self.selectedKey!=nil&&[view.key characterAtIndex:0]!=self.board.player){
            CBCPiece *pie = self.board.pieceMap[view.key];
            
            CBLocation *loc = pie.location;
            CBCPiece *selectPie = self.board.pieceMap[self.selectedKey];
            CBLocation *selectLoc = selectPie.location;
            for (CBLocation *loca in [CBCRules getNextMoveWithPiece:self.selectedKey location:selectLoc board:self.board]) {
                if (loca.x == loc.x&&loca.y == loc.y) {
                    NSString *key = view.key;
                    
                    [view removeFromSuperview];
                    [self.pieceObject removeObjectForKey:key];
                    [self.board updatePiece:self.selectedKey newLocation:loca];
                    [self movePieceFromModel:self.selectedKey toLocation:loca];
           //         self.board.player = (self.board.player == 'r') ? 'b' : 'r';
//                    if (self.board.player=='r') {
//                        self.board.player = 'b';
//                    }else{
//                        self.board.player = 'r';
//                    }
//                    self.selectedKey = nil;
                }
               
            }
            
        }
        
      //  NSLog(@"%@",view.key);
    }else if([touchView isKindOfClass:[self class]]){
        NSLog(@"棋盘");
        if(self.selectedKey!=nil){
            if ([self.selectedKey characterAtIndex:0]!=self.board.player) {
                return;
            }else{
            NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
            UITouch *touch = [allTouches anyObject];   //视图中的所有对象
            CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
            int x = point.x;
            int y = point.y;
            CBLocation *sloc=[[CBLocation alloc]init];
            sloc.x = x-5;
            sloc.y = y-5;
            CBLocation *loc = [self viewToModelConverter:sloc];
            CBCPiece *selectPie = self.board.pieceMap[self.selectedKey];
            CBLocation *selectLoc = selectPie.location;
            for (CBLocation *loca in [CBCRules getNextMoveWithPiece:self.selectedKey location:selectLoc board:self.board]) {
                if (loca.x == loc.x&&loca.y == loc.y) {
                 //   NSString *key = view.key;
                    
                   // [view removeFromSuperview];
                  //  [self.pieceObject removeObjectForKey:key];
                    [self.board updatePiece:self.selectedKey newLocation:loca];
                    [self movePieceFromModel:self.selectedKey toLocation:loca];
                  //  self.board.player = (self.board.player == 'r') ? 'b' : 'r';
                    //                    if (self.board.player=='r') {
                    //                        self.board.player = 'b';
                    //                    }else{
                    //                        self.board.player = 'r';
                    //                    }
                    //                    self.selectedKey = nil;
                }
                
            }
            
        }
        }
    }
    

}
-(void)movePieceFromAI:(NSString *)pieceKey location:(CBLocation *)to{
    CBCPiece *inNewLoc = [self.board getPieceWithLocation:to];
    if (![inNewLoc.key isEqualToString:@"nil"]&&inNewLoc!=nil) {
        CBCChessView *pieceView = self.pieceObject[inNewLoc.key];
        [pieceView removeFromSuperview];
        [self.pieceObject removeObjectForKey:inNewLoc.key];
        
    }
    CBCChessView *pieceObject = self.pieceObject[pieceKey];
    CBLocation *sloc = [self modelToViewConverter:to];
    pieceObject.layer.position = CGPointMake(sloc.x+20, sloc.y+20);
    self.selectedKey = nil;
}
-(void)movePieceFromModel:(NSString *)pieceKey toLocation:(CBLocation *)loc{
    CBCChessView *chess = self.pieceObject[pieceKey];
    
    CBLocation *sloc =[self modelToViewConverter:loc];
   // [chess setFrame:CGRectMake(sloc.x, sloc.y, 41, 41)];
    chess.layer.position = CGPointMake(sloc.x+20, sloc.y+20);
    self.selectedKey = nil;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)run{
    if (self.board.player == 'b') {
        char win = [self.control hasWin:self.board];
       
            CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
            CBCAlpaBetaNode *result = [searchModel search:self.board];
            [self movePieceFromAI:result.piece location:result.to];
            [self.board updatePiece:result.piece newLocation:result.to];
            if ([self.control hasWin:self.board]!='x') {
                return ;
            }
        
       
    }
   
    //    if ([self.control hasWin:self.board]=='x') {
    //        NSTimer *timer = [NSTimer timerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //            if (self.board.player=='r') {
    //                NSTimer*tt =  [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //                    NSLog(@"r");
    //
    //                }];
    //                [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    //            }
    //            CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
    //            CBCAlpaBetaNode *result = [searchModel search:self.board];
    //            [self.gameView movePieceFromAI:result.piece location:result.to];
    //            [self.board updatePiece:result.piece newLocation:result.to];
    //            if ([self.control hasWin:self.board]!='x') {
    //                return ;
    //            }
    //        }];
    //        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    //       // [self run];
    //    }
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
