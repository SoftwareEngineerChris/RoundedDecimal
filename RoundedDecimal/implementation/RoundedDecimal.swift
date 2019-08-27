//
//  RoundedDecimal.swift
//  RoundedDecimal
//
//  Created by Chris Hargreaves on 16/09/2018.
//  Copyright © 2018 Software Engineering Limited. All rights reserved.
//

import Foundation

public struct RoundedDecimal<T: DecimalPlaces>:
    Codable, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral,
    CustomStringConvertible, CustomDebugStringConvertible {
    
    public typealias IntegerLiteralType = Int
    public typealias StringLiteralType = String
    
    private let underlyingValue: Decimal
    
    // MARK: ExpressibleByStringLiteral implementation
    
    public init(stringLiteral: String) {
        
        let decimalValue = Decimal(string: stringLiteral) ?? .nan
        
        self.init(value: decimalValue)
    }
    
    // MARK: ExpressibleByIntegerLiteral implementation
    
    public init(integerLiteral value: IntegerLiteralType) {
        
        self.init(value: Decimal(value))
    }
    
    // MARK: Decodable implementation
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        let stringRepresentation = try container.decode(String.self)
        
        self.init(stringLiteral: stringRepresentation)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        try container.encode(description)
    }
    
    private init(value: Decimal) {
        
        let decimalHandler = NSDecimalNumberHandler(roundingMode: .bankers,
                                                    scale: T.count,
                                                    raiseOnExactness: false,
                                                    raiseOnOverflow: false,
                                                    raiseOnUnderflow: false,
                                                    raiseOnDivideByZero: false)
        
        self.underlyingValue = value.rounding(accordingToBehavior: decimalHandler)
    }
    
    public var isNaN: Bool {
        
        return underlyingValue.isNaN
    }
    
    public func withInferredPrecision<NewDecimalPlaces: DecimalPlaces>() -> RoundedDecimal<NewDecimalPlaces> {
        
        return RoundedDecimal<NewDecimalPlaces>(value: underlyingValue)
    }
    
    public static func / (rhs: RoundedDecimal, lhs: RoundedDecimal) -> RoundedDecimal {
        
        return RoundedDecimal(value: rhs.underlyingValue / lhs.underlyingValue)
    }
    
    public static func * (rhs: RoundedDecimal, lhs: RoundedDecimal) -> RoundedDecimal {
        
        return RoundedDecimal(value: rhs.underlyingValue * lhs.underlyingValue)
    }
    
    public static func + (rhs: RoundedDecimal, lhs: RoundedDecimal) -> RoundedDecimal {
        
        return RoundedDecimal(value: rhs.underlyingValue + lhs.underlyingValue)
    }
    
    public static func - (rhs: RoundedDecimal, lhs: RoundedDecimal) -> RoundedDecimal {
        
        return RoundedDecimal(value: rhs.underlyingValue - lhs.underlyingValue)
    }
    
    public static func nan() -> RoundedDecimal {
        
        return RoundedDecimal(value: .nan)
    }
    
    // MARK: CustomStringConvertible, CustomDebugStringConvertible implementation

    private let descriptionFormatter = { () -> NumberFormatter in
        
        let formatter = NumberFormatter()
        
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = Int(T.count)
        formatter.maximumFractionDigits = Int(T.count)
        
        return formatter
    }()
    
    public var description: String {
        
        return descriptionFormatter.string(from: underlyingValue as NSDecimalNumber)!
    }
    
    public var debugDescription: String {
        
        return description
    }
    
    enum CodingKeys: String, CodingKey {
        
        case underlyingValue
    }
}

extension RoundedDecimal: Equatable, Comparable {
    
    public static func == (rhs: RoundedDecimal, lhs: RoundedDecimal) -> Bool {

        return rhs.underlyingValue == lhs.underlyingValue
    }
    
    public static func < (rhs: RoundedDecimal, lhs: RoundedDecimal) -> Bool {
        
        return rhs.underlyingValue < lhs.underlyingValue
    }
}
