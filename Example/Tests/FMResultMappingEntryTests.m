//
//  FMResultMappingEntryTests.m
//  FMResultsMapping
//
//  Created by krivoblotsky on 11/25/15.
//  Copyright © 2015 Serg Krivoblotsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMResultMappingEntry.h"

@interface FMResultMappingEntryTests : XCTestCase

@end

@implementation FMResultMappingEntryTests

- (void)testConstuctor
{
    NSString *column = @"foo";
    NSString *key = @"key";
    
    id(^fooBlock)(NSString *, id) = ^id(NSString *key, id object) {
        return @"bar";
    };
    
    FMResultMappingEntry *entry = [FMResultMappingEntry entryWithColumn:column key:key valueBlock:fooBlock];
    XCTAssertEqual(column, entry.column);
    XCTAssertEqual(key, entry.key);
    XCTAssertEqual(fooBlock, entry.valueBlock);
}

@end
