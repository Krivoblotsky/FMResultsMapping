//
//  FMResultMappingEntry.h
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 MacPaw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef __nullable id(^FMResultMappingEntryValueBlock)(NSString *key, id object);

@interface FMResultMappingEntry : NSObject

/**
 *  Convenience initializer
 *
 *  @param column NSString
 *  @param key    NSString
 *
 *  @return FMResultMappingEntry
 */
+ (instancetype)entryWithColumn:(NSString *)column key:(NSString *)key valueBlock:(__nullable FMResultMappingEntryValueBlock)valueBlock;

@property (nonatomic, copy, readonly) NSString *column;
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) FMResultMappingEntryValueBlock valueBlock;

@end

NS_ASSUME_NONNULL_END
