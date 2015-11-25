//
//  FMResultSetMappingTests.m
//  FMResultsMapping
//
//  Created by krivoblotsky on 11/25/15.
//  Copyright © 2015 Serg Krivoblotsky. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMDB.h"
#import "FMResultSet+Mapping.h"

@interface FMResultSetMappingTests : XCTestCase

@end

@implementation FMResultSetMappingTests

- (void)testFetching
{
    /* Create in memory database instance */
    FMDatabase *database = [FMDatabase databaseWithPath:@""];
    
    if (![database open] || ![database goodConnection])
    {
        NSLog(@"Error db opening: %@", database.lastError);
        XCTFail("DB failed to create");
    }
    
    /* Create person table */
    [database executeUpdate:@"CREATE TABLE PERSON (\
     ID INT PRIMARY KEY     NOT NULL, \
     NAME           TEXT    NOT NULL, \
     AGE            INT     NOT NULL, \
     ADDRESS        CHAR(50), \
     BORN           TIMESTAMP )"];
    
    /* Fill with some data */
    NSInteger i = 0;
    NSArray *persons = @[@"John"];
    NSDate *bornDate = [NSDate dateWithTimeIntervalSince1970:100];
    for (NSString *name in persons)
    {
        [database executeUpdate:@"INSERT INTO PERSON (ID, NAME, AGE, ADDRESS, BORN) VALUES (?,?,?,?,?);",
         @(i),
         name,
         @(45),
         @"Infinite Loop, 1",
         @([bornDate timeIntervalSince1970])];
        i++;
    }

    NSString *query = @"SELECT * FROM PERSON";
    FMResultSet *resultsSet = [database executeQuery:query];
    
    NSMutableArray *results = [NSMutableArray new];
    while ([resultsSet next])
    {
        NSDictionary *mappedDict = [resultsSet dictionaryWithMapping:^(FMResultMapping *mapping)
                                    {
                                        /* Plain mapping */
                                        [mapping mapColumnValue:@"ID" toKey:@"personId"];
                                        [mapping mapColumnValue:@"NAME" toKey:@"name"];
                                        [mapping mapColumnValue:@"AGE" toKey:@"age"];
                                        [mapping mapColumnValue:@"ADDRESS" toKey:@"address"];
                                        
                                        /* Mapping with value block */
                                        [mapping mapColumnValue:@"BORN" toKey:@"birthDate" valueBlock:^id _Nullable(NSString * _Nonnull key, id  _Nonnull object)
                                         {
                                             NSTimeInterval interval = [object doubleValue];
                                             return [NSDate dateWithTimeIntervalSince1970:interval];
                                         }];
                                    }];
        [results addObject:mappedDict];
    }

    XCTAssertTrue(results.count == 1);
    
    NSDictionary *mappedPerson = results[0];
    
    NSNumber *personId = @(0);
    NSString *name = @"John";
    NSNumber *age = @(45);
    NSString *address = @"Infinite Loop, 1";
    
    XCTAssertTrue([personId isEqual:mappedPerson[@"personId"]]);
    XCTAssertTrue([name isEqual:mappedPerson[@"name"]]);
    XCTAssertTrue([age isEqual: mappedPerson[@"age"]]);
    XCTAssertTrue([address isEqual:mappedPerson[@"address"]]);
    XCTAssertTrue([bornDate isEqualToDate:mappedPerson[@"birthDate"]]);
}

@end
