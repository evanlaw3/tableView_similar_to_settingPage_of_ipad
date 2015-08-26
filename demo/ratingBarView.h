//
//  ratingBarView.h
//  jhjy
//
//  Created by 罗西 on 7/22/15.
//  Copyright (c) 2015 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ratingBarView : UIView

@property (nonatomic,assign) NSInteger starNumber;
/*
 *调整底部视图的颜色
 */
@property (nonatomic,strong) UIColor *viewColor;

/*
 *是否允许可触摸
 */
@property (nonatomic,assign) BOOL enable;
-(NSInteger)getStartNum;
- (id)initWithFrame:(CGRect)frame topImg:(NSString*)topImgName bottomImg:(NSString*)bottomImgName;
-(void)setViewColor:(UIColor *)backgroundColor;


@end
