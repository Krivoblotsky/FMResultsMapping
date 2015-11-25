//
//  FMResultSet+Mapping.m
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 MacPaw. All rights reserved.
//

#import "FMResultSet+Mapping.h"
#import "FMResultMappingEntry.h"

@implementation FMResultSet (Mapping)

- (NSDictionary *)dictionaryWithMapping:(void (^)(FMResultMapping *mapping))mappingBlock
{
    NSMutableDictionary *result = [NSMutableDictionary new];
    FMResultMapping *mapping = [FMResultMapping new];
    
    /* Fill mapping */
    mappingBlock(mapping);
    
    for (FMResultMappingEntry *entry in mapping.mappingEntries)
    {
        /* Retrieve the value */
        id object = [self objectForColumnName:entry.column];
        
        /* Transform if needed */
        if (entry.valueBlock != nil)
        {
            object = entry.valueBlock(entry.key, object);
        }
        
        /* Assign fetched value to result dict */
        if (object) result[entry.key] = object;
    }
    
    /* Return the result */
    return [result copy];
}

@end
