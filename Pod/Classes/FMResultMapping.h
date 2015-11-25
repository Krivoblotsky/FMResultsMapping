//
//  FMResultMapping.h
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 Krivoblotsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultMappingEntry.h"

NS_ASSUME_NONNULL_BEGIN

@class FMResultMappingEntry;
@interface FMResultMapping : NSObject

/**
 *  Maps sqlite column value to given dictionary key
 *
 *  @param columnName NSString
 *  @param key        NSString
 */
- (void)mapColumnValue:(NSString *)columnName toKey:(NSString *)key;

/**
 *  Maps sqlite column value to given dictionary key. Transforms the value with value block
 *
 *  @param columnName NSString
 *  @param key        NSString
 *  @param valueBlock FMResultMappingEntryValueBlock
 */
- (void)mapColumnValue:(NSString *)columnName toKey:(NSString *)key valueBlock:(__nullable FMResultMappingEntryValueBlock)valueBlock;

@property (nonatomic, assign, readonly) NSArray *mappingEntries;

@end

NS_ASSUME_NONNULL_END