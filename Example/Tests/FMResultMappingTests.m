//
//  FMResultMappingTests.m
//  FMResultsMapping
//
//  Created by krivoblotsky on 11/25/15.
//  Copyright © 2015 Serg Krivoblotsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMResultMapping.h"

@interface FMResultMappingTests : XCTestCase

@end

@implementation FMResultMappingTests


- (void)testAppending
{
    FMResultMapping *mapping = [[FMResultMapping alloc] init];
    
    [mapping mapColumnValue:@"1" toKey:@"a"];
    [mapping mapColumnValue:@"2" toKey:@"b"];
    [mapping mapColumnValue:@"3" toKey:@"c"];
    [mapping mapColumnValue:@"4" toKey:@"d"];
    
    XCTAssertTrue(mapping.mappingEntries.count == 4);
}

@end
