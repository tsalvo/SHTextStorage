//
//  SHLine.h
//  
//
//  Created by Tom Salvo on 10/17/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLine: NSObject
@property (nonatomic) NSRange range;
@property (nonatomic) double height;

- (instancetype)initWithRange:(NSRange)aLineRange height:(double)aHeight;
@end

NS_ASSUME_NONNULL_END
