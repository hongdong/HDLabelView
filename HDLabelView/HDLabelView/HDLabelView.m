//
//  HDLabelView.m
//  HDLabelView
//
//  Created by 洪东 on 16/1/19.
//  Copyright © 2016年 abnerh. All rights reserved.
//

#import "HDLabelView.h"
#import "HDLabelVIewLayout.h"
#import "HDLabelViewConfig.h"
#import "HDLabelViewCell.h"

static NSString *const HDLabelViewCellId = @"HDLabelViewCellId";

@interface HDLabelView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *mainCollection;
@property (nonatomic,strong) NSMutableArray   *dataArr;
@property (nonatomic,  copy) SelectedHandler  handler;

@end

@implementation HDLabelView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedHandler:(SelectedHandler)handler {
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1);
    self = [super initWithFrame:newFrame];
    if (!titles.count) {
        return self;
    }
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.dataArr = [titles mutableCopy];
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    HDLabelVIewLayout *layout = [[HDLabelVIewLayout alloc] init];
    WS(weakSelf)
    layout.titleAtIndexPathBlock =  ^(NSIndexPath *bIndexPath){
        return weakSelf.dataArr[bIndexPath.item];
    };
    layout.layoutFinishWithNumberOflineBlock = ^(NSInteger number){
        static NSInteger numberCount;
        if (numberCount == number) {
            return;
        }
        numberCount = number;
        HDLabelViewConfig *config = [HDLabelViewConfig sharedHDLabelViewConfig];
        CGFloat h = config.contentInsets.top+config.contentInsets.bottom+config.itemHeight*number+config.lineSpace*(number-1);
        weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, h);
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.mainCollection.frame = self.bounds;
        }];

    };
    self.mainCollection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.mainCollection.backgroundColor = [HDLabelViewConfig sharedHDLabelViewConfig].backgroundColor;
    self.mainCollection.allowsMultipleSelection = YES;
    self.mainCollection.delegate = self;
    self.mainCollection.dataSource = self;
    [self.mainCollection registerClass:[HDLabelViewCell class] forCellWithReuseIdentifier:HDLabelViewCellId];
    [self addSubview:self.mainCollection];
}

/**
 *  CollectionView的数据源和代理
 *
 *  @param collectionView
 *
 *  @return
 */

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HDLabelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HDLabelViewCellId forIndexPath:indexPath];
    [cell configCellWithTitle:self.dataArr[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handler) {
        NSUInteger index = indexPath.item;
        NSString *title = self.dataArr[index];
        self.handler(index,title);
    }
}

/**
 *  LabelView的公开方法
 *
 */

- (void)insertLabelWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.dataArr insertObject:title atIndex:index];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animated:animated];
}

- (void)insertLabelsWithTitles:(NSArray *)titles atIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.dataArr insertObjects:titles atIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:indexPaths animated:animated];
}

- (void)deleteLabelAtIndex:(NSUInteger)index animated:(BOOL)animated {
    [self deleteLabelsAtIndexes:[NSIndexSet indexSetWithIndex:index] animated:animated];
}

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.dataArr removeObjectsAtIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animated:animated];
}

- (void)reloadAllWithTitles:(NSArray *)titles {
    self.dataArr = [titles mutableCopy];
    [self.mainCollection reloadData];
}

- (void)performBatchUpdatesWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [self.mainCollection performBatchUpdates:^{
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.mainCollection insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.mainCollection deleteItemsAtIndexPaths:indexPaths];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (!animated) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
}

- (NSArray *)indexPathsWithIndexes:(NSIndexSet *)set {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    return [indexPaths copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
