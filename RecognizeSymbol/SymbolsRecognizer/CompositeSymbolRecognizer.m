#import "CompositeSymbolRecognizer.h"

@interface CompositeSymbolRecognizer ()

@property(nonatomic, strong) NSArray<id <Invariant>> *invariants;

@end

@implementation CompositeSymbolRecognizer

#pragma mark - Initialization

- (instancetype)initWithInvariants:(NSArray<id <Invariant>> *)invariants {
    self = [super init];
    if (self != nil) {
        self.invariants = invariants;
    }
    return self;
}

#pragma mark - Symbol Recognizer

// TODO: split on methods

- (NSString *)recognizeSymbolsFromText:(NSString *)text {
    // 2 d array
    NSMutableArray<NSArray<NSString *> *> *symbolVariants = [[NSMutableArray alloc] init];
    
    [self.invariants enumerateObjectsUsingBlock:^(id<Invariant>  _Nonnull invariant,
                                                  NSUInteger idx,
                                                  BOOL * _Nonnull stop) {
        NSArray<NSString *> * variants = [invariant recognizedSymbolVariants:text];
        if (variants != nil) {
            [symbolVariants addObject:variants];
        }
    }];
    
    // choose the most frequent symbol
    // hash map
    NSMutableDictionary<NSString *, NSNumber *> *symbolEntries = [[NSMutableDictionary alloc] init];
    
    [symbolVariants enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull symbols,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
        
        [symbols enumerateObjectsUsingBlock:^(NSString * _Nonnull symbol, NSUInteger idx, BOOL * _Nonnull stop) {
            if (symbolEntries[symbol]) {
                symbolEntries[symbol] = @(symbolEntries[symbol].integerValue + 1);
            }
            else {
                symbolEntries[symbol] = @(1);
            }
        }];
    }];
    
    __block NSString *resultSymbol = [[symbolEntries allKeys] firstObject];
    __block NSInteger maxSymbolsCount = 1;
    
    [symbolEntries enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull symbol,
                                                       NSNumber * _Nonnull entriesCount,
                                                       BOOL * _Nonnull stop) {
        
        if (entriesCount.integerValue > maxSymbolsCount) {
            resultSymbol = [symbol copy];
            maxSymbolsCount = entriesCount.integerValue;
        }
        
    }];
    
    return resultSymbol;
}

@end
