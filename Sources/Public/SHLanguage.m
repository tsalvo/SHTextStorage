//
//  SHLanguage.m
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import "SHLanguage.h"

@implementation SHLanguage

-(instancetype)initWithName:(NSString *)aName rules:(NSArray<SHRule *>*)aRules
{
    if (self = [super init])
    {
        self.languageName = aName;
        self.rules = aRules;
    }
}

@end
