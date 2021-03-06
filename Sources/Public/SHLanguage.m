//
//  SHLanguage.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHLanguage.h"
#import "SHRule.h"

@implementation SHLanguage

@synthesize languageName;
@synthesize rules;

-(instancetype)initWithName:(NSString *)aName rules:(NSArray<SHRule *>*)aRules
{
    if (self = [super init])
    {
        self.languageName = aName;
        self.rules = aRules;
    }
    
    return self;
}

-(instancetype)init
{
    self = [self initWithName:@"" rules:@[]];
    return self;
}

@end
