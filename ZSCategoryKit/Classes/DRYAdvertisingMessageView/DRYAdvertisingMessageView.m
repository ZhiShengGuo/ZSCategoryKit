//
//  DRYAdvertisingMessageView.m
//  zzMBank
//
//  Created by GuoZhisheng on 2018/2/6.
//  Copyright © 2018年 liuyi. All rights reserved.
//

#import "DRYAdvertisingMessageView.h"

@interface DRYAdvertisingMessageView ()

@end

@implementation DRYAdvertisingMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.viewBgColor = [UIColor whiteColor];
    self.picUrl = @"";
    self.boardMsgStr = @"自从用了鼎融易，心情变得好美丽";
    self.runLabelBgColor = [UIColor whiteColor];
    self.canClose = NO;
    [self addSubview:self.hintImageView];
    [self addSubview:self.runLabel];
    [self addSubview:self.closeBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUI];
}

- (DRYRunLabelView *)runLabel {
    if (_runLabel == nil) {
        _runLabel = [[DRYRunLabelView alloc] init];
        _runLabel.font = [UIFont systemFontOfSize:13];
        _runLabel.textColor = StyleColorNavigation;
        _runLabel.speed = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [_runLabel addGestureRecognizer:tap];
    }
    return _runLabel;
}

- (void)tapLabel:(UIGestureRecognizer *)tap {
    if (self.tapLabelBlock) {
        self.tapLabelBlock();
    }
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)closeBtnClick:(UIButton *)sender {
    if (self.closeBtnBlock) {
        self.closeBtnBlock();
    }
    [self removeFromSuperview];
}

- (UIImageView *)hintImageView {
    if (_hintImageView == nil) {
        _hintImageView = [[UIImageView alloc] init];
    }
    return _hintImageView;
}

- (void)updateUI {
    self.backgroundColor = self.viewBgColor;
    _runLabel.text = self.boardMsgStr;
    _runLabel.backgroundColor = self.runLabelBgColor;
    [_closeBtn setImage:self.closeBtnImage forState:UIControlStateNormal];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    BOOL havePic = [self.picUrl hasPrefix:@"http"] ? YES : NO;
    if (havePic == YES && self.canClose == YES) {
        self.hintImageView.frame = CGRectMake(20, 10, 10, 10);
        self.runLabel.frame = CGRectMake(40, 0, width - 80, height);
        self.closeBtn.frame = CGRectMake(width - 40, 0, 30, 30);
    } else if (havePic == NO && self.canClose == YES) {
        self.hintImageView.frame = CGRectMake(0, 0, 0, 0);
        self.runLabel.frame = CGRectMake(0, 0, width - 40, height);
        self.closeBtn.frame = CGRectMake(width - 40, 0, 30, 30);
    } else if (havePic == YES && self.canClose == NO) {
        self.hintImageView.frame = CGRectMake(20, 10, 10, 10);
        self.runLabel.frame = CGRectMake(40, 0, width - 40, height);
        self.closeBtn.frame = CGRectMake(0, 0, 0, 0);
    } else {
        self.hintImageView.frame = CGRectMake(0, 0, 0, 0);
        self.runLabel.frame = CGRectMake(0, 0, width, height);
        self.closeBtn.frame = CGRectMake(0, 0, 0, 0);
    }
}

@end
