//
//  CountDownView.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/28.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "CountDownView.h"

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

@end
