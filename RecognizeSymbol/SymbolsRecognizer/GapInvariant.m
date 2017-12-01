#import "GapInvariant.h"

@interface GapInvariant ()

@property(nonatomic, strong) NSDictionary<NSString *, NSArray <NSString *> *> *mapping;

@end

@implementation GapInvariant

#pragma mark - Initialization

- (instancetype)initWithSignatureMapping:(NSDictionary<NSString *, NSArray <NSString *> *> *)mapping {
    self = [super init];
    
    if (self != nil) {
        self.mapping = mapping;
    }
    
    return self;
}

#pragma mark - Invariant

- (NSString *)signatureForTextEncodedSymbol:(NSString *)text {
    return @"";
}

- (NSArray<NSString *> *)recognizedSymbolVariants:(NSString *)text {
    NSString *signature = [self signatureForTextEncodedSymbol:text];
    
    return self.mapping[signature];
}

+ (NSDictionary<NSString *, NSArray <NSString *> *> *)defaultMapping {
    // TODO: complete all symbols
    return @{ @"1" : @[ @"a", @"o", @"d"],
              @"2" : @[ @"b" ],
              @"0" : @[ @"f", @"h", @"c" ],
              };
}

@end
