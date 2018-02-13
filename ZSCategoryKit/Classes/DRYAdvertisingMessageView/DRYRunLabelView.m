//
//  DRYRunLabelView.m
//  zzMBank
//
//  Created by GuoZhisheng on 2018/2/7.
//  Copyright © 2018年 liuyi. All rights reserved.
//

#import "DRYRunLabelView.h"

@interface DRYRunLabelView ()

@property (nonatomic, assign) CGFloat offsetX; //x偏移量
@property (nonatomic, strong) UILabel *moveLabel;
@property (nonatomic, assign) CGFloat labelWidth; //label的宽度
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation DRYRunLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _speed = 0.2;
        [self initView];
        [self initTimer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_moveLabel sizeToFit];
    CGRect rect = _moveLabel.frame;
    if (_moveLabel.frame.size.width <= self.frame.size.width) {
        _moveLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _moveLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        rect.size.height = self.frame.size.height;
        _moveLabel.frame = rect;
        _offsetX = _moveLabel.frame.origin.x;
        _labelWidth = _moveLabel.frame.size.width;
    }
}

- (void)initView {
    [self addSubview:self.moveLabel];
}

- (UILabel *)moveLabel {
    if (_moveLabel == nil) {
        _moveLabel = [[UILabel alloc] init];
    }
    return _moveLabel;
}

- (void)initTimer {
    if (_timer == nil) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLabelAction)];
        _timer.frameInterval = 2.0;
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)setFont:(UIFont *)font {
    _moveLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _moveLabel.textColor = textColor;
}

- (void)setText:(NSString *)text {
    _moveLabel.text = text;
    self.clipsToBounds = YES;//设置了这个属性后才能局部显示
}

- (void)setSpeed:(CGFloat)speed{
    if (speed < 0) {
        speed = 0;
    } else if (speed > 1) {
        speed = 1;
    }
    _speed = speed * 5;
}

- (void)displayLabelAction{
    _labelWidth = self.moveLabel.frame.size.width;
    if (_labelWidth <= self.frame.size.width) return;//如果字能显示全则不移动
    
    CGRect rect = self.moveLabel.frame;
    _offsetX -= self.speed;
    rect.origin.x = _offsetX;
    self.moveLabel.frame = rect;
    if (_offsetX < -_labelWidth){
        _offsetX = _labelWidth;
    }
}

@end
