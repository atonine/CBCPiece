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
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择难度" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"简单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  self.hard = 1;
        //   [self run2];
        cvc.hard = @"1";
         [self presentViewController:cvc animated:YES completion:nil];
        //
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"困难" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  self.hard = 2;
        //  [self run3];
        cvc.hard  = @"2";
         [self presentViewController:cvc animated:YES completion:nil];
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [self presentViewController:actionSheet animated:YES completion:nil];
   
    
    
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
