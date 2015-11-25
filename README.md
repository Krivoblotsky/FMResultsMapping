# FMResultsMapping

![teaser](/screenshots/fm_teaser.png)

Small, but usefull FMResultSet extenstion which helps to obtain the results from SQLite. Inspired by (boy, almost stolen from) [EasyMapping] (https://github.com/EasyMapping/EasyMapping).

[![Build Status](https://img.shields.io/badge/platform-ios%2Fosx-blue.svg)](https://github.com/Krivoblotsky/FMResultsMapping)
[![Build Status](https://img.shields.io/badge/version-0.0.1-cdcdcd.svg)](https://github.com/Krivoblotsky/FMResultsMapping)

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

With <b>FMResultsMapping</b> you can do it in this way:

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

iOS8+

OSX 10.8+

## Inspiration

1. [EasyMapping](https://github.com/EasyMapping/EasyMapping)
2. [FMDB] (https://github.com/ccgus/fmdb)

## Installation

FMResultsMapping is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FMResultsMapping"
```

## Author

Serg Krivoblotsky, krivoblotsky@me.com

## License

FMResultsMapping is available under the MIT license. See the LICENSE file for more info.
