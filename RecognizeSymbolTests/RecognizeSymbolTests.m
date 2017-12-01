//
//  RecognizeSymbolTests.m
//  RecognizeSymbolTests
//
//  Created by Pavel Katunin on 12/1/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CompositeSymbolRecognizer.h"
#import "LineByLineInvariant.h"

@interface RecognizeSymbolTests : XCTestCase

@end

@implementation RecognizeSymbolTests

- (void)testRecognizerB {
    LineByLineInvariant *lineInvariant = [[LineByLineInvariant alloc]
                                          initWithSignatureMapping:[LineByLineInvariant defaultMapping]];
    
    CompositeSymbolRecognizer *recognizer = [[CompositeSymbolRecognizer alloc]
                                             initWithInvariants:@[lineInvariant]];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"testb" ofType:@"txt"];
    NSString *b = [recognizer recognizeSymbolsFromText:[NSString stringWithContentsOfFile:path
                                                                   encoding:NSUTF8StringEncoding
                                                                      error:nil]];
    
    NSLog(@"B %@", b);
    XCTAssertEqualObjects(b, @"b");
}

- (void)testLineByLineInvariantB {
    LineByLineInvariant *lineInvariant = [[LineByLineInvariant alloc]
                                          initWithSignatureMapping:[LineByLineInvariant defaultMapping]];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"testb" ofType:@"txt"];
    NSString *signature = [lineInvariant signatureForTextEncodedSymbol:[NSString stringWithContentsOfFile:path
                                                                           encoding:NSUTF8StringEncoding
                                                                              error:nil]];
    
    NSLog(@"B signature %@", signature);
    XCTAssertEqualObjects(signature, @"1,2,1,2,1");
}

- (void)testLineByLineInvariantC {
    LineByLineInvariant *lineInvariant = [[LineByLineInvariant alloc]
                                          initWithSignatureMapping:[LineByLineInvariant defaultMapping]];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"testc2" ofType:@"txt"];
    NSString *signature = [lineInvariant signatureForTextEncodedSymbol:[NSString stringWithContentsOfFile:path
                                                                                                  encoding:NSUTF8StringEncoding
                                                                                                     error:nil]];
    
    NSLog(@"C signature %@", signature);
    XCTAssertEqualObjects(signature, @"1");
}

- (void)testLineByLineInvariantA {
    LineByLineInvariant *lineInvariant = [[LineByLineInvariant alloc]
                                          initWithSignatureMapping:[LineByLineInvariant defaultMapping]];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"testa" ofType:@"txt"];
    NSString *signature = [lineInvariant signatureForTextEncodedSymbol:[NSString stringWithContentsOfFile:path
                                                                                                 encoding:NSUTF8StringEncoding
                                                                                                    error:nil]];
    
    NSLog(@"C signature %@", signature);
    XCTAssertEqualObjects(signature, @"1,2,1,2");
}

@end
