//
//  SHLine.m
//  
//
//  Created by Tom Salvo on 10/17/21.
//

#import "SHLine.h"

@implementation SHLine
@synthesize range;
@synthesize height;

- (instancetype)initWithRange:(NSRange)aRange height:(double)aHeight {
    if (self = [super init])
    {
        self.range = aRange;
        self.height = aHeight;
    }
    
    return self;
}

@end
