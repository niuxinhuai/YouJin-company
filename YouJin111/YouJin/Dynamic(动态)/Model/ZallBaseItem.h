//
//  ZallBaseItem.h
//  SOKit
//
//  Created by so on 16/5/30.
//  Copyright © 2016年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief  获取类的所有属性名称
 */
NSArray <NSString *> * ZallPropertyKeyList(Class cls);

/**
 *  @brief  KVC基础数据结构
 子类不需要重写description;
 子类不需要重写forwardInvocation；
 子类不需要实现NSCoding、NSCopying协议, 已自动实现;
 
 支持自动解析NSDictionary、NSArray的嵌套格式:
 必须通过get方法- (Class _Nonnull)xxxParseClass指出嵌套的类型, 例子:
 
 @interface TestItem : ZallBaseItem
 @property (copy, nonatomic, nullable) ZallBaseItem *item;
 @property (copy, nonatomic, nullable) NSArray <ZallBaseItem *> *subItems;
 
 - (Class _Nonnull)itemParseClass {
 return ([ZallBaseItem class]);
 }
 
 - (Class _Nonnull)subItemsParseClass {
 return ([ZallBaseItem class]);
 }
 
 @end
 */
@interface ZallBaseItem : NSObject <NSCoding, NSCopying>

/**
 *  @brief  类方法
 */
+ (instancetype)item;

/**
 *  @brief  类方法，从字典初始化
 */
+ (instancetype)itemWithDictionary:(NSDictionary *)dictionary;

/**
 *  @brief  从字典初始化
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  @brief  将属性组装成字典
 */
- (NSDictionary *)dictionary;

@end


/**
 *  @brief  简单组装items的分类
 */
@interface NSArray (ZallItems)
/**
 *  @brief  从元素为NSDictionary的数组array解析为元素为itemClass的数组, itemClass必须为ZallBaseItem或其子类
 */
+ (NSArray <__kindof ZallBaseItem * > *)itemsWithItemClass:(Class)itemClass JSONArray:(NSArray <__kindof NSDictionary *> *)array;

@end
