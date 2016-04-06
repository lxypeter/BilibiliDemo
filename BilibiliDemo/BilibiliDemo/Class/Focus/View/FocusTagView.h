//
//  FocusTagView.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock) ();

@interface TagRefreshButton : UIButton

@end

@interface FocusTagView : UIView

@property (nonatomic,copy) NSArray *tagArray;

//预留刷新按钮点击Block
@property (nonatomic,copy) ButtonClickBlock refreshButtonBlock;

//预留关注按钮点击Block
@property (nonatomic,copy) ButtonClickBlock focusButtonBlock;

@end
