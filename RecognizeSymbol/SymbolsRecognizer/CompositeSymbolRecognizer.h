#import <Foundation/Foundation.h>
#import "SymbolRecognizer.h"
#import "Invariant.h"

@interface CompositeSymbolRecognizer : NSObject <SymbolRecognizer>

- (instancetype)initWithInvariants:(NSArray<id <Invariant>> *)invariants;

@end
