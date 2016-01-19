//
//  HDLabelViewConfig.h
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MacroHeader.h"
@interface HDLabelViewConfig : NSObject
HDSingletonH(HDLabelViewConfig)

@property (nonatomic ,assign) UIEdgeInsets  contentInsets;
@property (nonatomic ,assign) CGFloat       textMargin;
@property (nonatomic ,assign) CGFloat       lineSpace;
@property (nonatomic ,assign) CGFloat       itemHeight;
@property (nonatomic ,assign) CGFloat       itemSpace;
@property (nonatomic ,assign) CGFloat       itemCornerRaius;
@property (nonatomic ,strong) UIColor       *itemColor;
@property (nonatomic ,strong) UIColor       *textColor;
@property (nonatomic ,strong) UIFont        *textFont;
@property (nonatomic ,strong) UIColor       *backgroundColor;


@end
