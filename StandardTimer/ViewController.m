//
//  ViewController.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/18.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *selectTimePicker;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)onTapLeftButton:(id)sender;
- (IBAction)onTapRightButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 左ボタンタップ時にコール
 */
- (IBAction)onTapLeftButton:(id)sender
{
    
}

/*
 右ボタンタップ時にコール
 */
- (IBAction)onTapRightButton:(id)sender
{
    
}

@end
