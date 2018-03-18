//
//  ViewController.m
//  CBChess
//
//  Created by 于洪志 on 2018/2/18.
//  Copyright © 2018年 于洪志. All rights reserved.
//

#import "ViewController.h"
#import "CBCGameController.h"
#import "CBIGameController.h"


@interface ViewController ()


@end

@implementation ViewController
- (IBAction)clickToChineseChess:(id)sender {
    
    CBCGameController *cvc = [[CBCGameController alloc]init];
    cvc.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:cvc animated:YES completion:nil];
    
    
}
- (IBAction)clickToIChess:(id)sender {
   
    CBIGameController *cvc = [[CBIGameController alloc]init];
    cvc.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
