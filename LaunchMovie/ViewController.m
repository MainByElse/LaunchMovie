//
//  ViewController.m
//  LaunchMovie
//
//  Created by Else丶 on 2019/1/25.
//  Copyright © 2019 Else丶. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"Welcome!";
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = [UIColor cyanColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}


@end
