//
//  DRYAdvertisingMessageView.h
//  zzMBank
//
//  Created by GuoZhisheng on 2018/2/6.
//  Copyright © 2018年 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRYRunLabelView.h"//滚动文字

typedef void(^DRYAdvertisingMessageViewBlock)(void);

@interface DRYAdvertisingMessageView : UIView

//展示的控件
@property (nonatomic, strong) UIImageView *hintImageView;//提示图片
@property (nonatomic, strong) UIButton *closeBtn;//关闭按钮
@property (nonatomic, strong) DRYRunLabelView *runLabel;//滚动文字

//展示的属性设置
@property (nonatomic, strong) UIColor *viewBgColor;//整体的背景颜色
@property (nonatomic, strong) NSString *picUrl;//图片url
@property (nonatomic, strong) NSString *boardMsgStr;//广播文字
@property (nonatomic, strong) UIColor *runLabelBgColor;//广告消息的背景颜色
@property (nonatomic, strong) UIImage *closeBtnImage;//关闭按钮的背景图
@property (nonatomic, assign) BOOL canClose;//是否可以关闭

//回调
@property (nonatomic, copy) DRYAdvertisingMessageViewBlock tapLabelBlock;
@property (nonatomic, copy) DRYAdvertisingMessageViewBlock closeBtnBlock;

@end
