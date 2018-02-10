//
//  RMMessageCodeBtn.m
//  zzMBank
//
//  Created by 郭志胜 on 2017/3/17.
//  Copyright © 2017年 liuyi. All rights reserved.
//

#import "RMMessageCodeBtn.h"

static dispatch_queue_t queueMessage;
static dispatch_source_t timerMessage;

@interface RMMessageCodeBtn ()
/**
 *  计数器时间
 */
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTimeInterval GoBackgroudtime;
@property (nonatomic, assign) NSTimeInterval nowtime;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, assign) NSInteger timeout;

@end

@implementation RMMessageCodeBtn

/**
 *  验证码按钮初始化
 *
 *  @param title 验证码按钮标题
 *  @param time  验证码按钮超时时间
 *
 *  @return 验证码实例
 */

- (instancetype)initWithTitle:(NSString*)title time:(NSInteger)time {
    self = [super init];
    self.time = time;
    self.title = title;
    if(self) {
//        self.layer.cornerRadius = 3;
//        self.clipsToBounds = YES;
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = UIColorFromHex(0xff9800).CGColor;
//        self.titleLabel.font = [UIFont systemFontOfSize:13];
//        [self setTitleColor:UIColorFromHex(0xff9800)
//                   forState:UIControlStateNormal];
//        [self setTitle:title forState:UIControlStateNormal];
//        [self addTarget:self action:@selector(verifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoForegroud) name:@"EnterForeground" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoBackgroud) name:@"willEnterBackground" object:nil];
    }
    return self;
}

- (void)appGoBackgroud {
    _GoBackgroudtime = [[NSDate date] timeIntervalSince1970];
}

- (void)appGoForegroud {
    _nowtime = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)_nowtime;
    long long int date1 = (long long int)_GoBackgroudtime;
    NSInteger i = date - date1;
    _timeout = _timeout - i;
}

#pragma mark - 获取验证码按钮点击方法
- (void)verifyBtnClick:(UIButton*)button {
    if ([self.delegate respondsToSelector:@selector(RMMessageCodeBtnClick:)]) {
        [self.delegate RMMessageCodeBtnClick:self];
    }
}

- (void)startTimer {
    _timeout= self.time - 1; //倒计时时间
    queueMessage = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timerMessage = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queueMessage);
    dispatch_source_set_timer(timerMessage, dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timerMessage, ^{
        if (_timeout <= 0) { //倒计时结束，关闭
            [self stopTimer];
        } else {
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)_timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@秒",strTime]
                      forState:UIControlStateNormal];
                self.layer.borderColor = [UIColor grayColor].CGColor;
                [self setTitleColor:[UIColor grayColor]
                           forState:UIControlStateNormal];
                self.enabled = NO;
            });
            _timeout--;
        }
    });
    dispatch_resume(timerMessage);
}

- (void)stopTimer {
    dispatch_source_cancel(timerMessage);
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.layer.borderColor = UIColorFromHex(0xff9800).CGColor;
//        [self setTitleColor:UIColorFromHex(0xff9800)
//                   forState:UIControlStateNormal];
//        self.enabled = YES;
    });
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"EnterForeground"  object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"willEnterBackground"  object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
