//
//  ViewController.m
//  CollectionCardPage
//
//  Created by ymj_work on 16/5/28.
//  Copyright © 2016年 ymj_work. All rights reserved.
//

#import "ViewController.h"
#import "CardPage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CardPage *cardPage = [[CardPage alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cardPage];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
