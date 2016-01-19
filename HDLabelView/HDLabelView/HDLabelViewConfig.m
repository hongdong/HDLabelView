//
//  HDLabelViewConfig.m
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDLabelViewConfig.h"

@implementation HDLabelViewConfig
HDSingletonM(HDLabelViewConfig)

- (instancetype)init {
    self = [super init];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(10, 15, 10, 15);
        self.lineSpace = 10;
        self.itemHeight = 25;
        self.itemSpace = 10;
        self.itemCornerRaius = 3;
        self.itemColor = [UIColor whiteColor];
        self.textMargin = 20;
        self.textColor = [UIColor darkTextColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    }
    return self;
}


@end
