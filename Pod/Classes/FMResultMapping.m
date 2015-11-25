//
//  FMResultMapping.m
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 MacPaw. All rights reserved.
//

#import "FMResultMapping.h"
#import "FMResultMappingEntry.h"

@interface FMResultMapping ()

@property (nonatomic, strong) NSMutableArray *keyValuePairs;

@end

@implementation FMResultMapping

@synthesize mappingEntries = _mappingEntries;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _keyValuePairs = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Public

- (void)mapColumnValue:(NSString *)columnName toKey:(NSString *)key
{
    [self mapColumnValue:columnName toKey:key valueBlock:nil];
}

- (void)mapColumnValue:(NSString *)columnName toKey:(NSString *)key valueBlock:(FMResultMappingEntryValueBlock)valueBlock
{
    FMResultMappingEntry *entry = [FMResultMappingEntry entryWithColumn:columnName key:key valueBlock:valueBlock];
    [self.keyValuePairs addObject:entry];
}

- (NSArray *)mappingEntries
{
    return [self.keyValuePairs copy];
}

@end

