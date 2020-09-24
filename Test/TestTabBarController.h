//
//  TestTabBarController.h
//  Test
//
//  Created by liwenjing on 2020/9/17.
//  Copyright © 2020 liwenjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestTabBarController : UITabBarController

- (instancetype)initWithRootViewControllers:(NSArray *)controllers
                                  andTitles:(NSArray *)titles
                              andImageNames:(NSArray *)imageNames
                      andImageSelectedNames:(NSArray *)imageSelectedNames;

@end

NS_ASSUME_NONNULL_END
