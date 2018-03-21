//
//  CBIGameController.m
//  CBChess
//
//  Created by 于洪志 on 2018/3/16.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "CBIGameController.h"
#import "CBIGameView.h"
#import "CBISearchModel.h"
@interface CBIGameController ()
@property (strong, nonatomic) CBIGameView *gameView;

/**
 <#注释#>
 */
@property (nonatomic,strong) CBIBoard *board;

/**
 <#注释#>
 */
@property (nonatomic,strong) CBIGameControl *control;

@end

@implementation CBIGameController

-(CBIGameControl *)control{
    if (_control==nil) {
        _control = [[CBIGameControl alloc]init];
        
    }
    return _control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.board = [self.control setBoard];
    _gameView = [[CBIGameView alloc]initWithBoard:self.board frame:CGRectMake(16, 114, 343, 368)];
    _gameView.image = [UIImage imageNamed:@"ichessboard.jpg"];
    [self.view addSubview:self.gameView];
 //  [self run];
  //  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)run{
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.board.player=='w') {
            
            
            return ;
            
        }
        CBISearchModel *searchModel = [[CBISearchModel alloc]init];
        CBCAlpaBetaNode *result = [searchModel search2:self.board];
        [self.gameView movePieceFromAI:result.piece location:result.to];
        [self.board updatePiece:result.piece newLocation:result.to];
        if ([self.control hasWin:self.board]!='x') {
            NSLog(@"结束了");
            return ;
        }
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

@end
