#import "NSString+LineReading.h"

@implementation NSString (LineReading)

- (NSArray<NSString *> *)lines {
    return [[NSMutableArray alloc] initWithArray:[self componentsSeparatedByString:@"\r\n"] copyItems: YES];;
}

@end
