//
//  lz4_objcTests.m
//  lz4-objcTests
//
//  Created by Josh Chung on 2/18/13.
//  Copyright (c) 2013 Josh Chung. All rights reserved.
//

#import "lz4_objcTests.h"
#import "NSData+LZ4.h"

@implementation lz4_objcTests {
    NSString *_testText;
    NSData *_testImageData;
}

- (void)setUp
{
    [super setUp];
    
    _testText = @"Again, you can't connect the dots looking forward; you can only connect them looking backwards. So you have to trust that the dots will somehow connect in your future. You have to trust in something — your gut, destiny, life, karma, whatever. This approach has never let me down, and it has made all the difference in my life.";
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"pizzi" ofType:@"png"];
    NSLog(@"path: %@", path);
    _testImageData = [[NSData alloc] initWithContentsOfFile:path];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testStringFastCompression
{
    NSData *originalData = [_testText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *compressedData = [originalData compressLZ4WithLevel:kLZ4FastCompression];
    STAssertNotNil(compressedData, @"Could not compress data");
    
    NSData *decompressedData = [compressedData decompressLZ4];
    STAssertNotNil(decompressedData, @"Could not decompress data");
    
    NSString *text = [[NSString alloc] initWithData:decompressedData encoding:NSUTF8StringEncoding];
    STAssertEqualObjects(_testText, text, @"Decompressed data doesn't match with original one");
}

- (void)testStringHighCompression
{
    NSData *originalData = [_testText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *compressedData = [originalData compressLZ4WithLevel:kLZ4HighCompression];
    STAssertNotNil(compressedData, @"Could not compress data");
    
    NSData *decompressedData = [compressedData decompressLZ4];
    STAssertNotNil(decompressedData, @"Could not decompress data");
    
    NSString *text = [[NSString alloc] initWithData:decompressedData encoding:NSUTF8StringEncoding];
    STAssertEqualObjects(_testText, text, @"Decompressed data doesn't match with original one");
}

- (void)testImageFastCompression
{
    NSData *compressedData = [_testImageData compressLZ4WithLevel:kLZ4FastCompression];
    STAssertNotNil(compressedData, @"Could not compress data");
    
    NSData *decompressedData = [compressedData decompressLZ4];
    STAssertNotNil(decompressedData, @"Could not decompress data");

    STAssertTrue([_testImageData isEqualToData:decompressedData], @"Decompressed data doesn't match with original one");
}

- (void)testImageHighCompression
{
    NSData *compressedData = [_testImageData compressLZ4WithLevel:kLZ4HighCompression];
    STAssertNotNil(compressedData, @"Could not compress data");
    
    NSData *decompressedData = [compressedData decompressLZ4];
    STAssertNotNil(decompressedData, @"Could not decompress data");
    
    STAssertTrue([_testImageData isEqualToData:decompressedData], @"Decompressed data doesn't match with original one");
}

@end
