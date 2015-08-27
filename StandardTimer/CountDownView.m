//
//  CountDownView.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/28.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "CountDownView.h"

#define updateCountDownLabel(hour,min,sec) [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hour,(unsigned long)min,(unsigned long)sec]

@interface CountDownView ()

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation CountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CountDownView"
                                              owner:self
                                            options:nil] firstObject];
        self.frame      = frame;
        self.alpha      = 0.0;
        self.hidden     = YES;
        self.totalTime  = 0;
    }
    
    return self;
}

#pragma mark -- Public

/*
 カウントダウンビューを表示
 */
- (void)showCountDownView
{
    self.hidden = NO;
    [self updateTimer];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 1.0;
                     }];
}

/*
 カウントダウンビューを非表示
 */
- (void)hideCountDownView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         
                         [self resetCountTimer];
                     }];
}

/*
 タイマーをリセット
 */
- (void)resetCountTimer
{
    self.countDownLabel.text =  updateCountDownLabel(0, 0, 0);
    
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

/*
 タイマーカウントを開始
 */
- (void)startCountTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timerUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
    self.countDownTimer = timer;
}

/*
 タイマーメソッド
 */
- (void)timerUpdate:(NSTimer *)timer
{
    if (self.totalTime > 0) {
        self.totalTime--;
        NSUInteger restTimeH = self.totalTime / 3600;
        NSUInteger restTimeM = (self.totalTime - restTimeH * 3600) / 60;
        NSUInteger resetTimeS = self.totalTime % 60;
        self.countDownLabel.text = updateCountDownLabel(restTimeH,restTimeM,resetTimeS);
    }
    else {
        [self resetCountTimer];
    }
}

/*
 タイマーカウントを停止
 */
- (void)stopCountTimer
{
    // カウントだけ止める
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

#pragma mark Private

/*
 時間表示更新
 */
- (void)updateTimer
{
    if (self.totalTime > 0) {
        NSUInteger hour = self.totalTime / 3600;
        NSUInteger min  = (self.totalTime - hour * 3600) / 60;
        NSUInteger sec  = self.totalTime % 60;
        self.countDownLabel.text =  updateCountDownLabel(hour, min, sec);
    }
    else {
        // フェールセーフ
        [self resetCountTimer];
    }
}

@end
