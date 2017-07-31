//
//  ViewController.m
//  wkwebview
//
//  Created by 冯文杰 on 2017/7/31.
//  Copyright © 2017年 冯文杰. All rights reserved.
//

#import "ViewController.h"
#import "RootWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RootWebViewController *vc = segue.destinationViewController;
    vc.requestURLString = @"http://union.liwai.com/zhiliaotoutiao/index?token=52c3d74afada7ea25fc926986487d332";
    vc.marginTop = 64;
    vc.automaticallyAdjustsScrollViewInsets = NO;
}


@end
