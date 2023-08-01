//
//  NSObject+AssociatedObjects.h
//  LeoOdyssey
//
//  Created by Leo Lee on 2023/8/1.
//  Copyright © 2023 LeoLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 对象关联
/// 属于 runtime 技术
/// 作用：对已经存在的类在扩展中添加自定义属性。弥补了Objective-C最大的缺点
/// 作用范围：可以运行在其架构上的所有代码
/// 主要用于：①添加私有属性实现细节；②添加公有属性来增强类别功能；③创建一个用于KVO的关联观察者。
///
@interface NSObject (AssociatedObjects)
@property (nonatomic, strong) id associatedObject;
@end

NS_ASSUME_NONNULL_END
