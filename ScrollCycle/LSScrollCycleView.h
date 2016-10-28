//
//  LSScrollCycleView.h
//  ScrollCycle
//
//  Created by 李景景 on 16/10/27.
//  Copyright © 2016年 Linkstores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSScrollCycleView : UIView

/** 图片数组 */
@property (nonatomic, strong) NSArray                   *imgArr;

/** UIPageController */

/** dots */
@property (nonatomic, strong) UIColor                   *dotsColor;
/** 当前dot颜色 */
@property (nonatomic, strong) UIColor                   *currentDotColor;

@end
