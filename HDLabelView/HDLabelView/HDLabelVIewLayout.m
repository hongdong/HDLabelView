//
//  HDLabelVIewLayout.m
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDLabelVIewLayout.h"
#import "HDLabelViewConfig.h"

typedef struct currentOrigin {
    CGFloat     lineX;
    NSInteger   lineNumber;
}currentOrigin;


@implementation HDLabelVIewLayout{
    UIEdgeInsets    contentInsets;
    CGFloat         itemHeight;
    CGFloat         itemSpace;
    CGFloat         lineSpace;
    CGFloat         itemMargin;
    UIFont          *titleFont;
    NSInteger       itemCount;
    currentOrigin   orgin;
}

- (void)prepareLayout {
    [super prepareLayout];
    HDLabelViewConfig *config = [HDLabelViewConfig sharedHDLabelViewConfig];
    contentInsets = config.contentInsets;
    titleFont = config.textFont;
    lineSpace = config.lineSpace;
    itemHeight = config.itemHeight;
    itemSpace = config.itemSpace;
    itemCount = [self.collectionView numberOfItemsInSection:0];
    itemMargin = config.textMargin;
    orgin.lineNumber = 0;
    orgin.lineX = contentInsets.left;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (NSInteger i = 0; i<attributesArray.count; i++) {
        UICollectionViewLayoutAttributes *att = attributesArray[i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSString *title = self.titleAtIndexPathBlock(indexPath);
        CGSize size = [self sizeWithTitle:title font:titleFont];
        CGFloat itemOrginX = orgin.lineX;
        CGFloat itemOrginY = orgin.lineNumber*(itemHeight+lineSpace) + contentInsets.top;
        CGFloat itemWidth = size.width+itemMargin;
        if (itemWidth > CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right)) {
            itemWidth = CGRectGetWidth(self.collectionView.frame)-(contentInsets.left+contentInsets.right);
        }
        att.frame = CGRectMake(itemOrginX, itemOrginY, itemWidth, itemHeight);
        orgin.lineX += itemWidth+itemSpace;
        if (i < attributesArray.count-1) {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:i+1 inSection:0];
            NSString *nextTitle = self.titleAtIndexPathBlock(nextIndexPath);
            CGSize nextSize = [self sizeWithTitle:nextTitle font:titleFont];
            if (nextSize.width+itemMargin > CGRectGetWidth(self.collectionView.frame)-contentInsets.right-orgin.lineX) {
                orgin.lineNumber ++;
                orgin.lineX = contentInsets.left;
            }
        }
        else {
            self.layoutFinishWithNumberOflineBlock(orgin.lineNumber + 1);
        }
    }
    return attributesArray;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    CGRect rect = [title boundingRectWithSize:CGSizeMake(1000, itemHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}



@end
