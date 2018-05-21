//
//  APIPOCTests.m
//  APIPOCTests
//
//  Created by tavant_sreejit on 5/19/18.
//  Copyright © 2018 tavant_sreejit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InfoTableViewController.h"
#import "CountryData.h"
#import "APIManager.h"

@interface APIPOCTests : XCTestCase

@property InfoTableViewController *vc;
@property NSString *validImageURL;
@property NSString *inValidImageURL;

@end

@implementation APIPOCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [InfoTableViewController.new init];
    self.validImageURL = @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    self.inValidImageURL = @"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    [super tearDown];
}

//Test to check is array 'content' is empty on vc initialization
- (void)testCountryDataIsEmpty {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //Given
    NSMutableArray *expectedData = self.vc.content;
    //When
    //Then
    XCTAssertTrue((expectedData.count == 0), @"Content should not be empty");
}

// Test to check response status code is 200
- (void)testAPISuccessResponse {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //Given
    NSMutableArray *expectedData = self.vc.content;
    //When
    //Then
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"API successfully returns 200 status code"];
    
    [APIManager.new fetchCountryDataWithBlock:^(NSDictionary *jsonDic, NSURLResponse *response) {
        // fetch the row data which is used to create the NSDictionary (_content) of CountryData
        if(response){
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            int code = [httpResponse statusCode];
            XCTAssertTrue((code == 200), @"Content SHOULD NOT be empty");
            [completionExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// Test to check the API call returns valid data to be passed on to array 'content'
- (void)testAPIFetchGetsData {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //Given
    NSMutableArray *expectedData = self.vc.content;
    //When
    //Then
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"API successfully fetched Country data"];
    [APIManager.new fetchCountryDataWithBlock:^(NSDictionary *jsonDic, NSURLResponse *response) {
        // fetch the row data which is used to create the NSDictionary (_content) of CountryData
        if(jsonDic[@"rows"]){
            self.vc.content = NSMutableArray.new;
            for (NSDictionary *itemData in jsonDic[@"rows"]){
                [self.vc.content addObject:[CountryData.new initWithDictionary:itemData]];
            }
        }
        NSDictionary *dataDic = jsonDic[@"rows"];
        XCTAssertTrue((dataDic.count > 0), @"Content SHOULD NOT be empty");
        [completionExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// Test if a valid UIImage is created after downloading from image url
- (void)testDownloadingImageURL {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //Given    
    //When
    NSURL *url = [NSURL URLWithString:self.validImageURL];
    //Then
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Image URL was successfully fetched and loaded"];
    [self.vc downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            XCTAssertNotNil(image,@"UIImage SHOULD NOT be NIL");
            [completionExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// Test if a valid UIImage is created after downloading from image url
- (void)testDownloadingInvalidImageURL {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //Given
    //When
    NSURL *url = [NSURL URLWithString:self.inValidImageURL];
    //Then
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Image URL was successfully fetched and loaded"];
    [self.vc downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            XCTAssertNil(image,@"UIImage SHOULD BE NIL");
            [completionExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
