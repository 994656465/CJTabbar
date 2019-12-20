//
//  CJTabbar.h
//  CJTabbar
//
//  Created by dd luo on 2019/12/19.
//  Copyright © 2019 dd luo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJTabbar : UITabBar
@property (nonatomic,copy) void(^centerButtonClickEvent)();

@end

NS_ASSUME_NONNULL_END
