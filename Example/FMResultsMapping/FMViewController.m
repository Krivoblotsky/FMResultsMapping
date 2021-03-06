//
//  FMViewController.m
//  FMResultsMapping
//
//  Created by Serg Krivoblotsky on 11/25/2015.
//  Copyright (c) 2015 Serg Krivoblotsky. All rights reserved.
//

#import "FMViewController.h"

#import "FMDB.h"
#import "FMResultSet+Mapping.h"
#import "FMResultsMapper.h"

@interface FMViewController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray *persons;
@property (nonatomic, strong) FMDatabase *database;

@property (nonatomic, strong) NSArray *fetchedPersons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    /* Create FAKE DB */
    [self _createFakeDatabase];
    
    /* Fetch the data and fill table */
    
    //One-by-one mapping
    [self _fetchPersons];

    /* Uncomment to try import */
//    //Import
//    [self _fetchPersons_import];
}

#pragma mark - Fetching

- (void)_fetchPersons
{
    NSString *query = @"SELECT * FROM PERSON";
    FMResultSet *resultsSet = [self.database executeQuery:query];
    
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
    self.fetchedPersons = [results copy];
}

- (void)_fetchPersons_import
{
    NSString *query = @"SELECT * FROM PERSON";
    FMResultSet *resultsSet = [self.database executeQuery:query];
    
    self.fetchedPersons = [FMResultsMapper importMappedResultsFromSet:resultsSet mapping:^(FMResultMapping *mapping)
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
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedPersons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *mappedDict = self.fetchedPersons[indexPath.row];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    NSDate *birthDate = mappedDict[@"birthDate"];
    NSString *bornString = [NSString stringWithFormat:@"Born: %@", [df stringFromDate:birthDate]];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.textLabel.text = mappedDict[@"name"];
    cell.detailTextLabel.text = bornString;
    return cell;
}

#pragma mark - DB Routines

- (void)_createFakeDatabase
{
    /* Create in memory database instance */
    self.database = [FMDatabase databaseWithPath:@""];
    
    if (![self.database open] || ![self.database goodConnection])
    {
        NSLog(@"Error db opening: %@", self.database.lastError);
    }
    
    /* Create person table */ 
    [self.database executeUpdate:@"CREATE TABLE PERSON (\
     ID INT PRIMARY KEY     NOT NULL, \
     NAME           TEXT    NOT NULL, \
     AGE            INT     NOT NULL, \
     ADDRESS        CHAR(50), \
     BORN           TIMESTAMP )"];
    
    /* Fill with some data */
    NSInteger i = 0;
    NSArray *persons = @[@"John", @"Mike", @"Peter", @"Andy", @"Marta"];
    for (NSString *name in persons)
    {
        [self.database executeUpdate:@"INSERT INTO PERSON (ID, NAME, AGE, ADDRESS, BORN) VALUES (?,?,?,?,?);",
         @(i),
         name,
         @(arc4random() % 80),
         @"Infinite Loop, 1",
         @([[NSDate date] timeIntervalSince1970] - arc4random() % 100000)];
        i++;
    }
}

@end
