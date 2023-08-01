//
//  NSObject+AssociatedObjects.m
//  LeoOdyssey
//
//  Created by Leo Lee on 2023/8/1.
//  Copyright © 2023 LeoLee. All rights reserved.
//
#import <objc/runtime.h>

#import "NSObject+AssociatedObjects.h"

@implementation NSObject (AssociatedObjects)

/// 告诉编译器这个属性的getter和setter方法由运行时动态生成，而不是编译时生成。
@dynamic associatedObject;

/// 关联对象的行为
/// OBJC_ASSOCIATION_ASSIGN = 0, 相当于 @property(assign) 或者 @property(unsafe_unretained)，指定一个关联对象的弱引用
/// OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, 相当于 @property(nonatomic, strong) ，指定一个关联对象的强引用，不能被原子化使用
/// OBJC_ASSOCIATION_COPY_NONATOMIC = 3, 相当于 @property(nonatomic, copy)，指定一个关联对象的copy引用，不能被原子化使用
/// OBJC_ASSOCIATION_RETAIN = 01401, 相当于 @property(atomic, strong)，指定一个关联对象的强引用，能被原子化使用
/// OBJC_ASSOCIATION_COPY = 01403，相当于 @property(atomic, copy)，指定一个关联对象的copy引用，能被原子化使用
- (void)setAssociatedObject:(id)object {
    objc_setAssociatedObject(self, @selector(associatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 通常推荐的做法是添加的属性Key值最好是 static char 类型。
/// 通常该Key值应该是常量、唯一的、在使用范围内用getter和setter访问到
/// static char kAssociatedObjectKey;
/// objc_getAssociatedObject(self, &kAssociatedObjectKey);

/*
 
 这里有一个更加巧妙的实现方式，使用SELs，因为SELs是唯一且恒定的。
 Since SELs are guaranteed to be unique and constant, you can use _cmd as the key for objc_setAssociatedObject(). #objective-c #snowleopard
 */

- (id)associatedObject {
    return objc_getAssociatedObject(self, @selector(associatedObject));
}

/// 删除关联对象属性值
/// 此函数的主要目的是在“初试状态”时方便地返回一个对象。你不应该用这个函数来删除对象的属性，因为可能会导致其他客户对其添加的属性也被移除了。规范的方法是：调用 objc_setAssociatedObject 方法并传入一个 nil 值来清除一个关联。
- (void)removeAssociatedObjectValues {
    objc_removeAssociatedObjects(self);
}

@end
