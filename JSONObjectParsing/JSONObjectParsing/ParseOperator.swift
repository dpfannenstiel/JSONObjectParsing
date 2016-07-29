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

public enum JSONParsingError: ErrorProtocol {
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

public func <== <T>(lhs:JSON, rhs:String) throws -> T {
	
	do {
		let result:T = try parse(lhs: lhs, rhs: rhs)
		return result
	} catch {
		throw error
	}
}

public func <== (lhs:JSON, rhs:String) throws -> String? {
	
	do {
		
		let result:String = try lhs <== rhs
		return result
		
	} catch JSONParsingError.KeyNotFound(keyName: _) {
		return nil
	} catch JSONParsingError.TypeMismatch(expectedType: _, actualType: "NSNull") {
		return nil
	} catch {
		throw error
	}
	
}

