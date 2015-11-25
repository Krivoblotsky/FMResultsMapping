//
//  FMResultSet+Mapping.h
//  CleanMyMac
//
//  Created by krivoblotsky on 11/24/15.
//  Copyright © 2015 MacPaw. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "FMResultMapping.h"

@interface FMResultSet (Mapping)

/**
 *  Returns mapped dictionary created with mapping block
 *
 *  @param mappingBlock void (^)(FMResultMapping *mapping)
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryWithMapping:(void (^)(FMResultMapping *mapping))mappingBlock;

@end
