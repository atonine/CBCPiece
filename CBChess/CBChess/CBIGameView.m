//
//  CBIGameView.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBIGameView.h"
#import "CBCChessView.h"

static int SY_COE =43,SX_COE = 46;

static int SY_OFFSET =0,SX_OFFSET = 0;

@interface CBIGameView()

@property(nonatomic ,strong)CBIBoard *board;
@property(nonatomic, strong)CBCChessView *pieceView;

@property(nonatomic ,strong)CBIGameControl *control;

/**
 key
 */
@property (nonatomic,strong) NSString *selectedKey;

@property (nonatomic,strong)NSMutableDictionary * pieceObject;

@end



@implementation CBIGameView{
    //   BOOL eated;
}

-(void)setControl:(CBIGameControl *)control{
    _control = control;
}

-(instancetype)initWithBoard:(CBIBoard *)board frame:(CGRect)frame{
    //  eated = NO;
    if (self=[super initWithFrame:frame]) {
      //  CBIGameView *ins = [self initWithFrame:frame];
        _pieceObject = [NSMutableDictionary dictionary];
        self.userInteractionEnabled = YES;
        _board = board;
        NSDictionary *dic = board.pieceMap;
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            CBCPiece *piece =  dic[key];
            CBLocation *loc = piece.location;
            CBLocation*sloc = [self modelToViewConverter:loc];
            CBCChessView *chessVeiw = [[CBCChessView alloc]initWithFrame:CGRectMake(sloc.x, sloc.y, 43, 45)];
            chessVeiw.userInteractionEnabled = YES;
            chessVeiw.key = key;
            NSString *imageName = [NSString stringWithFormat:@"%@.png",[key substringWithRange:NSMakeRange(0, 2)]];
            [chessVeiw setImage:[UIImage imageNamed:imageName]];
            [_pieceObject setObject:chessVeiw forKey:key];
            [self addSubview:chessVeiw];
        }
    }
    return self;
    
}

-(CBLocation *)modelToViewConverter:(CBLocation *)loc{
    CBLocation *sloc = [[CBLocation alloc]init];
    sloc.y = loc.x * SX_COE+SX_OFFSET;
    sloc.x = loc.y * SY_COE +SY_OFFSET;
    return sloc;
}
-(CBLocation *)viewToModelConverter:(CBLocation *)sloc{
    CBLocation *loc = [[CBLocation alloc]init];
    int y = (sloc.x -SX_OFFSET)/SX_COE;
    int x = (sloc.y -SY_OFFSET)/SY_COE;
    loc.x = x;
    loc.y = y;
    return loc;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //   [self run];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *touchView = [touch view];
    
    if ([touchView isKindOfClass:[CBCChessView class]]) {
        CBCChessView *view = (CBCChessView *)touchView;
        CBCPiece *piece = self.board.pieceMap[view.key];
        NSLog(@"%@",view.key);
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
            for (CBLocation *loca in [CBIRules getNextMoveWithPiece:self.selectedKey location:selectLoc board:self.board]) {
                if (loca.x == loc.x&&loca.y == loc.y) {
                    //    eated = YES;
                    NSString *key = view.key;
                    
                    [view removeFromSuperview];
                    [self.pieceObject removeObjectForKey:key];
                    [self.board updatePiece:self.selectedKey newLocation:loca];
                    [self movePieceFromModel:self.selectedKey toLocation:loca];
                    NSArray *arr = [self.board.pieceMap allKeys];
                    NSLog(@"%zd",arr.count);
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
                sloc.x = x;
                sloc.y = y;
                CBLocation *loc = [self viewToModelConverter:sloc];
                CBCPiece *selectPie = self.board.pieceMap[self.selectedKey];
                CBLocation *selectLoc = selectPie.location;
                for (CBLocation *loca in [CBIRules getNextMoveWithPiece:self.selectedKey location:selectLoc board:self.board]) {
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
    pieceObject.layer.position = CGPointMake(sloc.x, sloc.y);
    self.selectedKey = nil;
}
-(void)movePieceFromModel:(NSString *)pieceKey toLocation:(CBLocation *)loc{
    CBCChessView *chess = self.pieceObject[pieceKey];
    
    CBLocation *sloc =[self modelToViewConverter:loc];
    // [chess setFrame:CGRectMake(sloc.x, sloc.y, 41, 41)];
    chess.layer.position = CGPointMake(sloc.x, sloc.y);
    self.selectedKey = nil;
}
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

