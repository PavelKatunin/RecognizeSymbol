#import "NSArray+Signature.h"

@implementation NSArray (Signature)

- (NSString *)stringWithSeparator:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

@end
