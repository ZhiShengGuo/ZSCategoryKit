//
//  RMMessageCodeBtn.h
//  zzMBank
//
//  Created by 郭志胜 on 2017/3/17.
//  Copyright © 2017年 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMMessageCodeBtn;
@protocol RMMessageCodeBtnDelegate <NSObject>
@optional
- (void)RMMessageCodeBtnClick:(RMMessageCodeBtn*)RMMessageCodeBtn;

@end

@interface RMMessageCodeBtn : UIButton

@property (nonatomic, weak) id<RMMessageCodeBtnDelegate> delegate;
/**
 *  验证码按钮初始化
 *
 *  @param title 验证码按钮标题
 *  @param time  验证码按钮超时时间
 *
 *  @return 验证码实例
 */
- (instancetype)initWithTitle:(NSString*)title time:(NSInteger)time;

- (void)startTimer;
- (void)stopTimer;

@end
