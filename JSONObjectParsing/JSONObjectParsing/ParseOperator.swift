//
//  ParseOperator.swift
//  JSONObjectParsing
//
//  Created by Dustin Pfannenstiel on 7/29/16.
//  Copyright © 2016 Dustin Pfannenstiel. All rights reserved.
//

import Foundation

/// A convienience declaration for Dictionaries that are supported by the parse
/// operators.
public typealias JSON = [String:Any]

public enum JSONParsingError: Error {
	/// The requested key was not available in the JSON object.
	case KeyNotFound(keyName:String)
	
	/// The type being returned by the requested key is not castable to the
	/// expected type.
	case TypeMismatch(expectedType:String, actualType:String)
}

/// The parse operator.
infix operator <== {}

/// The mutating parse operator.
infix operator <=% {}

/// Parse 
func parse<T>(lhs:JSON, rhs:String) throws -> T {
	
	guard lhs[rhs] != nil else {
		let error = JSONParsingError.KeyNotFound(keyName:rhs)
		throw error
	}
	
	guard let result = lhs[rhs] as? T else {
		let error = JSONParsingError.TypeMismatch(expectedType: "\(T.self)", actualType: String(lhs[rhs]!.dynamicType))
		throw error
	}
	
	return result
}

func optionalParse<T>(lhs:JSON, rhs:String) throws -> T? {
    
    do {
        
        let result:T = try parse(lhs: lhs, rhs: rhs)
        return result
        
    } catch JSONParsingError.KeyNotFound(keyName: _) {
        return nil
    } catch JSONParsingError.TypeMismatch(expectedType: _, actualType: "NSNull") {
        return nil
    } catch {
        throw error
    }

}

// MARK: - String
public func <== (lhs:JSON, rhs: String) throws -> String {
	
    return try parse(lhs: lhs, rhs: rhs)

}

public func <== (lhs:JSON, rhs:String) throws -> String? {
	
    return try optionalParse(lhs: lhs, rhs: rhs)

}

// MARK: - Int
public func <== (lhs:JSON, rhs: String) throws -> Int {
    
    return try parse(lhs: lhs, rhs: rhs)
    
}

public func <== (lhs:JSON, rhs:String) throws -> Int? {
    
    return try optionalParse(lhs: lhs, rhs: rhs)
    
}

// MARK: - Double
public func <== (lhs:JSON, rhs: String) throws -> Double {
    
    return try parse(lhs: lhs, rhs: rhs)
    
}

public func <== (lhs:JSON, rhs:String) throws -> Double? {
    
    return try optionalParse(lhs: lhs, rhs: rhs)
    
}

// MARK: - Float
public func <== (lhs:JSON, rhs: String) throws -> Float {
    
    return try parse(lhs: lhs, rhs: rhs)
    
}

public func <== (lhs:JSON, rhs:String) throws -> Float? {
    
    return try optionalParse(lhs: lhs, rhs: rhs)
    
}

