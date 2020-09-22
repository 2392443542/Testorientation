//
//  TestViewController.h
//  Test
//
//  Created by liwenjing on 2020/9/10.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestViewController : TestBaseViewController

@property (nonatomic, copy) void(^callback) ();

@end

NS_ASSUME_NONNULL_END
