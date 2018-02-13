//
//  DRYRunLabelView.h
//  zzMBank
//
//  Created by GuoZhisheng on 2018/2/7.
//  Copyright © 2018年 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRYRunLabelView : UIView

@property (nonatomic, strong) UIColor *textColor;//字体颜色
@property (nonatomic, strong) UIFont *font;//字体大小
@property (nonatomic, copy) NSString *text;//要显示的内容
@property (nonatomic, assign) CGFloat speed;//移动的速度[0~1],默认是0.2

@end
