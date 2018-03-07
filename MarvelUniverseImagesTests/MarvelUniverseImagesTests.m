//
//  MarvelUniverseImagesTests.m
//  MarvelUniverseImagesTests
//
//  Created by Katerina on 05.03.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURL+URLQueryBuilder.h"

@interface MarvelUniverseImagesTests : XCTestCase

@end

@implementation MarvelUniverseImagesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAsynchronousURLConnection {
    NSString *baseURL = @"https://gateway.marvel.com:443/v1/public/characters";
    NSString *description = [NSString stringWithFormat:@"GET %@", baseURL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    // 1. given
    NSDictionary *parametersDictionary = @{
                            @"ts"  : @"1",
                            @"apikey" : @"8a500a4f258ff08764dc94dd384f89ba",
                            @"hash" : @"628edffe7332977ebb65762bbadf241f"
                            };
    NSURL *URL = [NSURL ars_queryWithString:baseURL queryElements:parametersDictionary];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
   
    // 2. when
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      // 3. then
                                      XCTAssertNotNil(data, "data should not be nil");
                                      XCTAssertNil(error, "error should be nil");
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
                                          XCTAssertEqualObjects(httpResponse.URL.absoluteString, URL.absoluteString, @"HTTP response URL should be equal to original URL");
                                          XCTAssertEqualObjects(httpResponse.MIMEType, @"application/json", @"HTTP response content type should be application/json");
                                      } else {
                                          XCTFail(@"Response was not NSHTTPURLResponse");
                                      }
                                      
                                      [expectation fulfill];
                                  }];
    
    [task resume];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
}

@end
