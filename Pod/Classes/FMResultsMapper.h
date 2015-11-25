//
//  FMResultsMapper.h
//  Pods
//
//  Created by krivoblotsky on 11/25/15.
//
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "FMResultMapping.h"

@interface FMResultsMapper : NSObject

/**
 *  Imports and array of mapped dictionaries result. Experimental.
 *
 *  @param resultsSet   FMResultSet
 *  @param mappingBlock FMResultMapping
 *
 *  @return NSArray <NSDictionary *>
 */
+ (NSArray <NSDictionary *> *)importMapperResultsFromSet:(FMResultSet *)resultsSet mapping:(void (^)(FMResultMapping *mapping))mappingBlock;

@end
