//
//  ViewController.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/18.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    TimerStateIdle      = 0,    // 通常
    TimerStateCounting  = 1,    // カウント中
    TimerStateStopped   = 2,    // 一時停止中
} TimerState;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *selectTimePicker;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, assign) TimerState timerState;

- (IBAction)onTapLeftButton:(id)sender;
- (IBAction)onTapRightButton:(id)sender;

@end

@implementation ViewController

#pragma mark -- Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- Public

#pragma mark -- Private

/*
 タイマー開始
 */
- (void)startTimer
{
    self.timerState = TimerStateCounting;
    
    // カウントダウンビューを表示、時間設定
    
    // カウントダウンビューのアニメーション開始
}

/*
 タイマー一時停止
 */
- (void)stopTimer
{
    self.timerState = TimerStateStopped;
    
    // カウントダウンビューのアニメーション停止
}

/*
 タイマーキャンセル
 */
- (void)cancelTimer
{
    self.timerState = TimerStateIdle;
    
    // カウントダウンビューを非表示、時間リセット
}

#pragma mark -- Button Action Event

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
