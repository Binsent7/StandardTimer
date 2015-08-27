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
}

/*
 タイマーカウントを開始
 */
- (void)startCountTimer
{
#warning カウントダウン処理
}

/*
 タイマーカウントを停止
 */
- (void)stopCountTimer
{
#warning カウントだけとめる処理
}

#pragma mark Private

/*
 カウント開始
 */
- (void)startTimer
{
    
}

/*
 カウント停止
 */
- (void)stopTimer
{
    
}

/*
 時間表示更新
 */
- (void)updateTimer
{
    NSLog(@"タイマー更新");
    if (self.totalTime > 0) {
        NSUInteger hour = self.totalTime / 3600;
        NSUInteger min  = (self.totalTime - hour * 3600) / 60;
        NSUInteger sec  = self.totalTime / 60;
        NSLog(@"%d",sec);
        self.countDownLabel.text =  updateCountDownLabel(hour, min, sec);
        NSLog(@"%@",self.countDownLabel.text);
    }
    else {
        [self resetCountTimer];
    }
}

@end
