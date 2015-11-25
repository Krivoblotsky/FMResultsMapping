# FMResultsMapping

Small, but usefull FMResultSet extenstion which helps to obtain the results from SQLite. Inspired (boy, almost stolen from) EasyMapping.

[![CI Status](http://img.shields.io/travis/Serg Krivoblotsky/FMResultsMapping.svg?style=flat)](https://travis-ci.org/Serg Krivoblotsky/FMResultsMapping)
[![Version](https://img.shields.io/cocoapods/v/FMResultsMapping.svg?style=flat)](http://cocoapods.org/pods/FMResultsMapping)
[![License](https://img.shields.io/cocoapods/l/FMResultsMapping.svg?style=flat)](http://cocoapods.org/pods/FMResultsMapping)
[![Platform](https://img.shields.io/cocoapods/p/FMResultsMapping.svg?style=flat)](http://cocoapods.org/pods/FMResultsMapping)

## Usage

What's the usual way we deal with FMResultSet?

Something like that:

```objc
NSString *query = @"SELECT * FROM PERSON";
FMResultSet *resultsSet = [self.database executeQuery:query];

NSMutableArray *results = [NSMutableArray new];
while ([resultsSet next])
{
    NSInteger personId = [resultsSet intForColumn:@"ID"];
    NSString *name = [resultsSet stringForColumn:@"name"];
    NSInteger age = [resultsSet intForColumn:@"age"];
    NSString *address = [resultsSet stringForColumn:@"ADDRESS"];
    
    NSTimeInterval interval = [resultsSet doubleForColumn:@"BORN"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    [dictionary setObject:@(personId) forKey:@"personId"];
    
    if (name != nil) {
        [dictionary setObject:name forKey:@"name"];
    }
    
    if (age > 0) {
        [dictionary setObject:@(age) forKey:@"birthDate"];
    }
    
    if (address != nil) {
        [dictionary setObject:address forKey:@"address"];
    }
    
    if (date != nil) {
        [dictionary setObject:date forKey:@"birthDate"];
    }
    
    [results addObject:dictionary];
}
```
Arrrgggh, what a horridness:)

With FMResultsMapping you can write it in this way:

```objc
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
```

... or even:
```objc
NSString *query = @"SELECT * FROM PERSON";
FMResultSet *resultsSet = [self.database executeQuery:query];

NSArray *results = [FMResultsMapper importMappedResultsFromSet:resultsSet mapping:^(FMResultMapping *mapping)
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
```

Pretty nice and clean, yeah? 

###Advantages:
1. Re-using mappings
2. No boilerplate code nightmare
3. Value transforming via Value Blocks.

This example transforms unix time interval stored in sqlite database into NSDate
```objc
/* Mapping with value block */
[mapping mapColumnValue:@"BORN" toKey:@"birthDate" valueBlock:^id _Nullable(NSString * _Nonnull key, id  _Nonnull object)
 {
     NSTimeInterval interval = [object doubleValue];
     return [NSDate dateWithTimeIntervalSince1970:interval];
 }];
```

## Requirements

## Installation

FMResultsMapping is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FMResultsMapping"
```

## Author

Serg Krivoblotsky, krivoblotsky@macpaw.com

## License

FMResultsMapping is available under the MIT license. See the LICENSE file for more info.
