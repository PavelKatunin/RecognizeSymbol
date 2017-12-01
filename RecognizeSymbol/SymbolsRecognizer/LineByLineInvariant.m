#import "LineByLineInvariant.h"
#import "NSString+LineReading.h"
#import "NSArray+Signature.h"

@interface LineByLineInvariant ()

@property(nonatomic, strong) NSDictionary<NSString *, NSArray <NSString *> *> *mapping;

@end

@implementation LineByLineInvariant

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
    NSArray<NSString *> *lines = text.lines;
    
    __block NSInteger previousCrossLinesCount = 0;
    
    NSMutableArray *resultSignature = [[NSMutableArray alloc] init];
    
    [lines enumerateObjectsUsingBlock:^(NSString * _Nonnull line,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop) {
        NSInteger currentCrossLinesCount = [self crossLinesInTextLine:line];
        
        if (previousCrossLinesCount != currentCrossLinesCount && currentCrossLinesCount != 0) {
            [resultSignature addObject:@(currentCrossLinesCount)];
            previousCrossLinesCount = currentCrossLinesCount;
        }
        
    }];
    
    return [resultSignature stringWithSeparator:@","];
}

- (NSInteger)crossLinesInTextLine:(NSString *)textLine {
    
    __block NSString *previousSymbol = @" ";
    __block NSInteger result = 0;
    
    [textLine enumerateSubstringsInRange:NSMakeRange(0, [textLine length])
                                 options:NSStringEnumerationByComposedCharacterSequences
                              usingBlock:^(NSString * _Nullable substring,
                                           NSRange substringRange,
                                           NSRange enclosingRange,
                                           BOOL * _Nonnull stop) {
                                  if (![substring isEqualToString:previousSymbol]) {
                                      if ([previousSymbol isEqualToString:@" "]) {
                                          result++;
                                      }
                                      previousSymbol = [substring copy];
                                  }
                              }];
    
    return result;
}

- (NSArray<NSString *> *)recognizedSymbolVariants:(NSString *)text {
    NSString *signature = [self signatureForTextEncodedSymbol:text];
    
    return self.mapping[signature];
}

+ (NSDictionary<NSString *, NSArray <NSString *> *> *)defaultMapping {
    // TODO: complete all symbols
    return @{ @"1,2,1,2,1" : @[ @"b"],
              @"1,2,1,2" : @[ @"a" ],
              @"1,2,1" : @[ @"o", @"d" ],
              @"1" : @[ @"c", @"e", @"f", @"i", @"j", @"l" ],
              @"2,1,2" : @[@"h", @"k"],
              @"2,4,3,2" : @[@"m"]
              };
}

@end
