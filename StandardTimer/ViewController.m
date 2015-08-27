//
//  ViewController.m
//  StandardTimer
//
//  Created by hishinuma on 2015/07/18.
//  Copyright (c) 2015年 binsent. All rights reserved.
//

#import "ViewController.h"
#import "CountDownView.h"

typedef enum {
    TimerStateIdle      = 0,    // 通常
    TimerStateCounting  = 1,    // カウント中
    TimerStateStopped   = 2,    // 一時停止中
} TimerState;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgoundView;
@property (weak, nonatomic) IBOutlet UIPickerView *selectTimePicker;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, assign) TimerState timerState;
@property (nonatomic) CountDownView *countDownView;
@property (nonatomic, strong) NSMutableArray *timerPickerData;

- (IBAction)onTapLeftButton:(id)sender;
- (IBAction)onTapRightButton:(id)sender;

@end

@implementation ViewController

#pragma mark -- Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    // 初期化、セッター、ゲッター、解放時は「self.」でなく「_」で記述
    [_countDownView removeFromSuperview];
    _countDownView = nil;
    
    if (self.timerPickerData) {
        [self.timerPickerData removeAllObjects];
        self.timerPickerData = nil;
    }
}

#pragma mark -- <UIPickerViewDataSource>

/*
 コンポーネント数
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.timerPickerData.count;
}

/*
 セル数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.timerPickerData[component] count];
}

#pragma mark -- <UIPickerViewDelegate>

/*
 セルのタイトル表示内容
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.timerPickerData[component][row];
    return title;
}

/*
 セルの横幅
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = 120.0f;
    
    return width;
}

#pragma mark -- Public

#pragma mark -- Private

/*
 初期化
 */
- (void)initialize
{
    self.selectTimePicker.delegate = self;
    self.selectTimePicker.dataSource = self;
    
    // 時間
    NSMutableArray *hours = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 24; i++) {
        [hours addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    // 分
    NSMutableArray *times = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 60; i++) {
        [times addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    // 時間、分情報を格納
    _timerPickerData = [[NSMutableArray alloc] initWithCapacity:0];
    [self.timerPickerData addObject:hours];
    [self.timerPickerData addObject:times];
    
    // 時間ラベル
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 69, 100, 24)];
    hourLabel.text              = @"時間";
    hourLabel.font              = [UIFont boldSystemFontOfSize:20];
    hourLabel.backgroundColor   = [UIColor clearColor];
    hourLabel.shadowColor       = [UIColor whiteColor];
    hourLabel.shadowOffset      = CGSizeMake(0, 1);
    hourLabel.userInteractionEnabled = NO;
    
    // 分ラベル
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 69, 100, 24)];
    minLabel.text              = @"分";
    minLabel.font              = [UIFont boldSystemFontOfSize:20];
    minLabel.backgroundColor   = [UIColor clearColor];
    minLabel.shadowColor       = [UIColor whiteColor];
    minLabel.shadowOffset      = CGSizeMake(0, 1);
    minLabel.userInteractionEnabled = NO;
    
    [self.selectTimePicker addSubview:hourLabel];
    [self.selectTimePicker addSubview:minLabel];
    
    [self setupViews];
}

/*
 ビューを初期化
 */
- (void)setupViews
{
    CGRect frame = CGRectMake(0,
                              self.backgoundView.frame.origin.y,
                              self.view.frame.size.width,
                              self.backgoundView.frame.size.height);
    _countDownView = [[CountDownView alloc] initWithFrame:frame]; // 生成、セッター、ゲッター、解放時は「self.」でなく「_」で記述
    [self.view addSubview:self.countDownView];
}

/*
 タイマー開始
 */
- (void)startTimer
{
    NSLog(@"タイマー：開始");
    self.timerState = TimerStateCounting;
    
    // 時間設定
    // 選択中の行数
    NSUInteger hourRow  = [self.selectTimePicker selectedRowInComponent:0];
    NSUInteger minRow   = [self.selectTimePicker selectedRowInComponent:1];
    
    // 行数を元にトータルの秒数を計算
    NSUInteger hourCount = hourRow * 60 * 60;
    NSUInteger minCount = minRow * 60;
    NSUInteger timeCountSec = hourCount + minCount;
    self.countDownView.totalTime = timeCountSec;
    
    // カウントダウンビューを表示
    [self.countDownView showCountDownView];
    
    // カウント開始
    [self.countDownView startCountTimer];
}

/*
 タイマー一時停止
 */
- (void)stopTimer
{
    NSLog(@"タイマー：一時停止");
    self.timerState = TimerStateStopped;
    
    // カウント一時停止
    [self.countDownView stopCountTimer];
}

/*
 タイマーキャンセル
 */
- (void)cancelTimer
{
    NSLog(@"タイマー：キャンセル");
    self.timerState = TimerStateIdle;
    
    // カウントダウンビューを非表示
    [self.countDownView hideCountDownView];
}

#pragma mark -- Button Action Event

/*
 左ボタンタップ時にコール
 */
- (IBAction)onTapLeftButton:(id)sender
{
    switch (self.timerState) {
        case TimerStateIdle:
        case TimerStateStopped:
            // 開始
            [self startTimer];
            break;
            
        default:
            // 一時停止
            [self stopTimer];
            break;
    }
}

/*
 右ボタンタップ時にコール
 */
- (IBAction)onTapRightButton:(id)sender
{
    switch (self.timerState) {
        case TimerStateCounting:
        case TimerStateStopped:
            // キャンセル
            [self cancelTimer];
            break;
            
        default:
            break;
    }
}

@end
