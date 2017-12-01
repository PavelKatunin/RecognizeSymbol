#import <Foundation/Foundation.h>

@protocol Invariant <NSObject>

- (instancetype)initWithSignatureMapping:(NSDictionary<NSString *, NSArray <NSString *> *> *)mapping;

- (NSString *)signatureForTextEncodedSymbol:(NSString *)text;

- (NSArray<NSString *> *)recognizedSymbolVariants:(NSString *)text;

// here is a default mapping, also we can create a mapping for every font
+ (NSDictionary<NSString *, NSArray <NSString *> *> *)defaultMapping;

@end
