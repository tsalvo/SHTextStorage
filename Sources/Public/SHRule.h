//
//  SHRule.h
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import <Foundation/Foundation.h>

#import "SHCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHRule: NSObject
-(instancetype) initWithPattern:(NSString *)aPattern
                        options:(NSRegularExpressionOptions)aOptions
                       category:(SHCategory)aCategory NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) NSString *regexPattern;
@property (nonatomic) NSRegularExpressionOptions regexOptions;
@property (nonatomic) SHCategory category;

@end

NS_ASSUME_NONNULL_END
