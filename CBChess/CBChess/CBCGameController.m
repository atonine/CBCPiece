//
//  CBCGameController.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/27.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBCGameController.h"
#import "CBCGameView.h"
#import "CBCGameControl.h"
#import "CBCSearchModel.h"

@interface CBCGameController ()
/**
 qishitu
 */
@property (strong, nonatomic)  CBCGameView *gameView;
/**
 <#注释#>
 */
@property (nonatomic,strong) CBCGameControl *control;
/**
String : CBCChessView
 */
@property (nonatomic,strong) NSMutableDictionary *chessDic;

/**
 棋盘类
 */
@property (nonatomic,strong) CBCBoard *board;



@end

@implementation CBCGameController

-(CBCGameControl *)control{
    if (_control==nil) {
        _control = [[CBCGameControl alloc]init];
        
    }
    return _control;
}

- (void)viewDidLoad {
   // CBCGameControl *control = [[CBCGameControl alloc]init];
    self.board = [self.control startChess];
    self.gameView = [[CBCGameView alloc] initWithBoard:self.board frame:CGRectMake(16, 116, 343, 398)];
    self.gameView .image = [UIImage imageNamed:@"ChessBoard.png"];
    [self.view addSubview:self.gameView];
    [super viewDidLoad];
    UIButton *closedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closedBtn.frame = CGRectMake(343, 20, 60, 40);
    [closedBtn setTitle:@"关闭" forState:UIControlStateNormal];
    //[closedBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    closedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [closedBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closedBtn];
    [self run3];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)run{
    dispatch_queue_t queue = dispatch_queue_create("de",DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        while ([self.control hasWin:self.board]=='x') {
            while (self.board.player=='r') {
                [NSThread sleepForTimeInterval:1];
            }
            CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
            CBCAlpaBetaNode *result = [searchModel search:self.board];
            [self.gameView movePieceFromAI:result.piece location:result.to];
            [self.board updatePiece:result.piece newLocation:result.to];
            if ([self.control hasWin:self.board]!='x') {
                    return ;
            }
        }
    });
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
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)run2{
            NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                if (self.board.player=='r') {
                    
    
                    return ;
                  
                }
                CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
                CBCAlpaBetaNode *result = [searchModel search2:self.board];
                [self.gameView movePieceFromAI:result.piece location:result.to];
                [self.board updatePiece:result.piece newLocation:result.to];
                if ([self.control hasWin:self.board]!='x') {
                    return ;
                }
            }];
            [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
           // [self run];
    
}
-(void)run3{
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.board.player=='r') {
            
            
            return ;
            
        }
        CBCSearchModel *searchModel = [[CBCSearchModel alloc]init];
        CBCAlpaBetaNode *result = [searchModel search:self.board];
        [self.gameView movePieceFromAI:result.piece location:result.to];
        [self.board updatePiece:result.piece newLocation:result.to];
        if ([self.control hasWin:self.board]!='x') {
            NSLog(@"结束了");
            return ;
        }
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    // [self run];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"11111");
}
@end
