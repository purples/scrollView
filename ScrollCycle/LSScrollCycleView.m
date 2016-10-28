//
//  LSScrollCycleView.m
//  ScrollCycle
//
//  Created by 李景景 on 16/10/27.
//  Copyright © 2016年 Linkstores. All rights reserved.
//

#import "LSScrollCycleView.h"

#import "LSScrollCycleCell.h"

@interface LSScrollCycleView ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView                  *collectionView;

@property (nonatomic, strong) UIPageControl                     *page;

@end


@implementation LSScrollCycleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
     
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    //注册cell
    [self.collectionView registerClass:[LSScrollCycleCell class] forCellWithReuseIdentifier:NSStringFromClass([LSScrollCycleCell class])];

    
    [self addSubview:self.collectionView];
    
    self.page = [[UIPageControl alloc] init];
    self.page.currentPage = 1;
    [self addSubview:self.page];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    CGFloat page_h = 25;
    self.page.frame = CGRectMake(0, self.bounds.size.height - page_h, self.bounds.size.width, page_h);
    if (self.collectionView.contentOffset.x == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSScrollCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LSScrollCycleCell class]) forIndexPath:indexPath];
    cell.imgName = self.imgArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / self.bounds.size.width;
    self.page.currentPage = currentPage - 1;
    if (currentPage == self.imgArr.count - 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (currentPage == 0) {
        if (scrollView.contentOffset.x < (self.bounds.size.width / 2)) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.imgArr.count - 2 inSection:0];
            self.page.currentPage = self.imgArr.count - 2;
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row = %zd, %@", indexPath.row - 1, self.imgArr[indexPath.row]);
}

- (void)setImgArr:(NSArray *)imgArr
{
    NSMutableArray *mutA = [NSMutableArray arrayWithArray:imgArr];
    [mutA addObject:imgArr[0]];
    [mutA insertObject:[imgArr lastObject] atIndex:0];
    _imgArr = mutA;
    self.page.numberOfPages = _imgArr.count - 2;
    self.page.currentPage = 0;
    //只有一张图片不显示圆点
    if (_imgArr.count == 3) {
        self.page.hidesForSinglePage = YES;
    } else {
        self.page.hidesForSinglePage = NO;
    }
    [self.collectionView reloadData];
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)setDotsColor:(UIColor *)dotsColor
{
    self.page.pageIndicatorTintColor = dotsColor;
}

- (void)setCurrentDotColor:(UIColor *)currentDotColor
{
    self.page.currentPageIndicatorTintColor = currentDotColor;
}

@end
