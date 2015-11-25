//
//  FMResultMappingEntry.m
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 Krivoblotsky. All rights reserved.
//

#import "FMResultMappingEntry.h"

@interface FMResultMappingEntry ()

@property (nonatomic, copy, readwrite) NSString *column;
@property (nonatomic, copy, readwrite) NSString *key;
@property (nonatomic, copy, readwrite) FMResultMappingEntryValueBlock valueBlock;

@end

@implementation FMResultMappingEntry

+ (instancetype)entryWithColumn:(NSString *)column key:(NSString *)key valueBlock:(__nullable FMResultMappingEntryValueBlock)valueBlock
{
    FMResultMappingEntry *entry = [[self alloc] init];
    entry.column = column;
    entry.key = key;
    entry.valueBlock = valueBlock;
    return entry;
}

@end
