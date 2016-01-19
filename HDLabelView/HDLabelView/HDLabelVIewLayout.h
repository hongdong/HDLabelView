//
//  HDLabelVIewLayout.h
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString*(^TitleAtIndexPathBlock)(NSIndexPath *indexPath);
typedef void(^LayoutFinishWithNumberOflineBlock)(NSInteger number);

@interface HDLabelVIewLayout : UICollectionViewFlowLayout

@property (nonatomic ,copy) TitleAtIndexPathBlock titleAtIndexPathBlock;

@property (nonatomic ,copy) LayoutFinishWithNumberOflineBlock layoutFinishWithNumberOflineBlock;

@end
