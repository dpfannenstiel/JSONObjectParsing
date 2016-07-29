//
//  StringParsingTests.swift
//  JSONObjectParsing
//
//  Created by Dustin Pfannenstiel on 7/29/16.
//  Copyright © 2016 Dustin Pfannenstiel. All rights reserved.
//

import XCTest
@testable import JSONObjectParsing

class StringParsingTests: XCTestCase {
	
	let testJSON:JSON = ["stringKey1":"stringValue1", "doubleKey1":7.0, "nullKey1":NSNull()]
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testStringExists() {
		
		let test:String = try! testJSON <== "stringKey1"
		let manualRetrieval = testJSON["stringKey1"] as! String
		XCTAssertTrue(test == manualRetrieval, "The expected value was not present in the provided JSON.")
		
	}
	
	func testKeyNotFound() {
		
		let testKey = "stringKeyNotFound"
		
		do {
			let _:String = try testJSON <== testKey
			XCTFail("Successfully parsed a key not present in the JSON")
		} catch JSONParsingError.KeyNotFound(let attemptedKey) {
			XCTAssertTrue(attemptedKey == testKey, "Returned attempted key does not match requsted key.")
		} catch {
			XCTFail("An unexpected error has been caught.  ERROR: \(error)")
		}
		
	}
	
	func testUnexpectedType() {
		
		do {
			let _:String = try testJSON <== "doubleKey1"
			XCTFail("Successfully parsed a key returning an invalid type.")
		} catch JSONParsingError.TypeMismatch(expectedType: let expected, actualType: let actual) {
			XCTAssert(expected == "String" && actual == "Double", "Unexpected types inferred.")
		} catch {
			XCTFail("An unexpected error has been caught.  ERROR: \(error)")
		}
	}
	
	func testOptionalStringKey() {
		
		let test:String? = try! testJSON <== "stringKey1"
		let manualRetrieval = testJSON["stringKey1"] as! String
		XCTAssertTrue(test == manualRetrieval, "The expected value was not present in the provided JSON.")
		
	}
	
	func testOptionalStringNotFound() {
		let test:String? = try! testJSON <== "keyDoesNotExist"
		XCTAssertTrue(test == nil, "Somehow retrieved a value.")
	}
	
	func testNSNullInJSON() {
		let test:String? = try! testJSON <== "nullKey1"
		XCTAssertTrue(test == nil, "Somehow retrieved a value.")
	}
	
	func testWrongType() {
		do {
			let _:String? = try testJSON <== "doubleKey1"
			XCTFail("Successfully parsed a key returning an invalid type.")
		} catch JSONParsingError.TypeMismatch(expectedType: let expected, actualType: let actual) {
			XCTAssert(expected == "String" && actual == "Double", "Unexpected types inferred.")
		} catch {
			XCTFail("An unexpected error has been caught.  ERROR: \(error)")
		}
	}
}
