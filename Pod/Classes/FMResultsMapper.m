//
//  FMResultsMapper.m
//  Pods
//
//  Created by krivoblotsky on 11/25/15.
//
//

#import "FMResultsMapper.h"
#import "FMResultSet+Mapping.h"

@implementation FMResultsMapper

+ (NSArray <NSDictionary *> *)importMappedResultsFromSet:(FMResultSet *)resultsSet mapping:(void (^)(FMResultMapping *mapping))mappingBlock
{
    NSMutableArray *results = [NSMutableArray new];
    while ([resultsSet next])
    {
        NSDictionary *mappedDict = [resultsSet dictionaryWithMapping:mappingBlock];
        [results addObject:mappedDict];
    }
    return [results copy];
}

@end
