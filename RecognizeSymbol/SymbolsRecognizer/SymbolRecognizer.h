#import <Foundation/Foundation.h>

@protocol SymbolRecognizer <NSObject>

- (NSString *)recognizeSymbolsFromText:(NSString *)text;

@end
