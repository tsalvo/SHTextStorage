//
//  SHLanguage.h
//  
//
//  Created by Tom Salvo on 9/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SHRule;
@interface SHLanguage : NSObject

@property (nonatomic, retain) NSString *languageName;
@property (nonatomic, retain) NSArray<SHRule *> *rules;

-(instancetype)initWithName:(NSString *)aName rules:(NSArray<SHRule *>*)aRules;
@end

NS_ASSUME_NONNULL_END
