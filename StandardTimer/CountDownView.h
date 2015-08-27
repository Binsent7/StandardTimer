//
//  CountDownView.h
//  StandardTimer
//
//  Created by hishinuma on 2015/07/28.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownView : UIView

@property (nonatomic, assign) NSUInteger totalTime;

- (void)showCountDownView;
- (void)hideCountDownView;

- (void)resetCountTimer;
- (void)startCountTimer;
- (void)stopCountTimer;

@end
