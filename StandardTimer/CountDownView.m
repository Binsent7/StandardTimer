//
//  CountDownView.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/28.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "CountDownView.h"

#define updateCountDownLabel(hour,min,sec) [NSString stringWithFormat:@"%2d:%2d:%2d",hour,min,sec]

@interface CountDownView ()

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end

@implementation CountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CountDownView"
                                      owner:self
                                    options:nil];
    }
    
    return self;
}

#pragma mark -- Public

/*
 タイマーをリセット
 */
- (void)resetCountTimer
{
    updateCountDownLabel(0, 0, 0);
}

/*
 タイマーカウントを開始
 */
- (void)startCountTimer
{
    
}

/*
 タイマーカウントを停止
 */
- (void)stopCountTimer
{
    
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
    
}

@end
