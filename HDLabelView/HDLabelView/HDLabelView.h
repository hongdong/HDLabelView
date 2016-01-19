//
//  HDLabelView.h
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedHandler)(NSUInteger index,NSString *title);


@interface HDLabelView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
              selectedHandler:(SelectedHandler)handler;

- (void)insertLabelWithTitle:(NSString *)title
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertLabelsWithTitles:(NSArray *)titles
                     atIndexes:(NSIndexSet *)indexes
                      animated:(BOOL)animated;

- (void)deleteLabelAtIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;

- (void)reloadAllWithTitles:(NSArray *)titles;


@end
