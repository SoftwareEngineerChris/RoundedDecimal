//
//  RoundedDecimalTests.swift
//  RoundedDecimalTests
//
//  Created by Chris Hargreaves on 16/09/2018.
//  Copyright © 2018 Software Engineering Limited. All rights reserved.
//

import XCTest
import RoundedDecimal

class RoundedDecimalTests: XCTestCase {
    
    // MARK: Initialisation
    
    func test_initWithString_validDecimalString_returnsRoundedDecimal() {
        
        let decimal: RoundedDecimal<Places.two> = "1.25"
        
        XCTAssertEqual(decimal.description, "1.25")
        
        XCTAssertFalse(decimal.isNaN)
    }
    
    func test_initWithString_invalidDecimalString_returnsNil() {
        
        let decimal: RoundedDecimal<Places.two> = "a1.25"
        
        XCTAssertTrue(decimal.isNaN)
    }
    
    func test_initWithIntegerLiteral_returnsRoundedDecimal() {
        
        let decimal: RoundedDecimal<Places.two> = 163
        
        XCTAssertNotNil(decimal)
        
        XCTAssertEqual(decimal, "163.00")
    }
    
    // MARK: Equatable
    
    func test_equatable_isEqual_returnsTrue() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.25"
        
        XCTAssertEqual(decimalA, decimalB)
    }
    
    func test_equatable_isNotEqual_returnsFalse() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.26"
        
        XCTAssertNotEqual(decimalA, decimalB)
    }
    
    func test_equatable_roundsToSameValue_returnsTrue() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.251"
        
        XCTAssertEqual(decimalA, decimalB)
    }
    
    func test_equatable_roundsToDifferentValue_returnsFalse() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.259"
        
        XCTAssertNotEqual(decimalA, decimalB)
    }
    
    // MARK: Comparable
    
    func test_comparable_lessThan_lhsLessThanRhs_returnsTrue() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.26"
        
        XCTAssertTrue(decimalA < decimalB)
    }
    
    func test_comparable_lessThan_lhsGreaterThanRhs_returnsFalse() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.26"
        
        let decimalB: RoundedDecimal<Places.two> = "1.25"
        
        XCTAssertFalse(decimalA < decimalB)
    }
    
    func test_comparable_greaterThan_lhsLessThanRhs_returnsFalse() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.26"
        
        XCTAssertFalse(decimalA > decimalB)
    }
    
    func test_comparable_greaterThan_lhsGreaterThanRhs_returnsTrue() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.26"
        
        let decimalB: RoundedDecimal<Places.two> = "1.25"
        
        XCTAssertTrue(decimalA > decimalB)
    }
    
    // MARK: Arithmetic
    
    func test_addition_addsCorrectly() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "7.76"
        
        let result = decimalA + decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "9.01"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_subtraction_subtractsCorrectly() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "7.76"
        
        let result = decimalA - decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "-6.51"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_division_dividesCorrectly() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "7.76"
        
        let result = decimalA / decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "0.16"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_division_fromZero_dividesCorrectly_zero() {
        
        let decimalA: RoundedDecimal<Places.two> = "0"
        
        let decimalB: RoundedDecimal<Places.two> = "7.76"
        
        let result = decimalA / decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "0"
        
        XCTAssertEqual(result, expectedResult)
        
        XCTAssertFalse(result.isNaN)
    }
    
    func test_division_byZero_isNaN() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "0"
        
        let result = decimalA / decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = .nan()
        
        XCTAssertEqual(result, expectedResult)
        
        XCTAssertTrue(result.isNaN)
    }
    
    func test_multiplication_multipliesCorrectly() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "7.76"
        
        let result = decimalA * decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "9.7"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_multiplication_byZero_multipliesCorrectly_zero() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "0"
        
        let result = decimalA * decimalB
        
        let expectedResult: RoundedDecimal<Places.two> = "0"
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_precidence_bodmas1() {
        
        let result: RoundedDecimal<Places.two> = 30 - 2 * 5
        
        XCTAssertEqual(result, 20)
    }
    
    func test_precidence_bodmas2() {
        
        let result: RoundedDecimal<Places.two> = 20 + 21 / 3 * 2
        
        XCTAssertEqual(result, 34)
    }
    
    // MARK: withInferredPrecision
    
    func test_withInferredPrecision_smallerToLargerNumberOfPlaces_retainsAccuracyAndPrecision() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.five> = decimalA.withInferredPrecision()
        
        let expectedDecimal: RoundedDecimal<Places.five> = "1.25000"
        
        XCTAssertEqual(decimalB, expectedDecimal)
        
        XCTAssertEqual(decimalB.description, "1.25000")
    }
    
    func test_withInferredPrecision_largerToSmallerNumberOfPlaces_losesPrecisionRatainsAccuracy() {
        
        let decimalA: RoundedDecimal<Places.five> = "1.25900"
        
        let decimalB: RoundedDecimal<Places.two> = decimalA.withInferredPrecision()
        
        let expectedDecimal:RoundedDecimal<Places.two> = "1.26"
        
        XCTAssertEqual(decimalB, expectedDecimal)
        
        XCTAssertEqual(decimalB.description, "1.26")
    }
    
    // MARK: isNaN
    
    func test_isNaN_validNumber_returnsFalse() {
        
        let result: RoundedDecimal<Places.two> = 10 / 2
        
        XCTAssertEqual(result, 5)
        
        XCTAssertFalse(result.isNaN)
    }
    
    func test_isNaN_invalidNumber_returnsTrue() {
        
        let result: RoundedDecimal<Places.two> = 10 / 0
        
        XCTAssertEqual(result, .nan())
        
        XCTAssertTrue(result.isNaN)
    }
    
    // MARK: Codable
    
    func test_codable_toAndFromSameType_equates() {
        
        let roundedDecimal: RoundedDecimal<Places.five> = "1.97647802"
        
        guard let data = try? JSONEncoder().encode([roundedDecimal]) else { return XCTFail() }
        
        guard let decodedRoundedDecimalArray = try? JSONDecoder().decode([RoundedDecimal<Places.five>].self, from: data) else { return XCTFail() }
        
        XCTAssertEqual(decodedRoundedDecimalArray, ["1.97648"])
    }
    
    func test_codable_toLesserDecimalType_usesLesserTypeForRounding() {
        
        let roundedDecimal: RoundedDecimal<Places.five> = "1.97647802"
        
        guard let data = try? JSONEncoder().encode([roundedDecimal]) else { return XCTFail() }
        
        guard let decodedRoundedDecimalArray = try? JSONDecoder().decode([RoundedDecimal<Places.two>].self, from: data) else { return XCTFail() }
        
        XCTAssertEqual(decodedRoundedDecimalArray, ["1.98"])
    }
    
    func test_codable_toGreaterDecimalType_retainsAccuracy() {
        
        let roundedDecimal: RoundedDecimal<Places.two> = "1.97"
        
        guard let data = try? JSONEncoder().encode([roundedDecimal]) else { return XCTFail() }
        
        guard let decodedRoundedDecimalArray = try? JSONDecoder().decode([RoundedDecimal<Places.five>].self, from: data) else { return XCTFail() }
        
        XCTAssertEqual(decodedRoundedDecimalArray, ["1.97"])
    }
    
    func test_encodable_representedAsRootLevelString() {
        
        let roundedDecimalArray: [RoundedDecimal<Places.two>] = ["1.97"]
        
        guard let data = try? JSONEncoder().encode(roundedDecimalArray) else { return XCTFail() }
        
        guard let json: [String] = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String] else { return XCTFail() }
        
        XCTAssertEqual(json.first, "1.97")
    }
    
    // MARK: CustomStringConvertible, CustomDebugStringConvertible
    
    func test_description_returnsCorrectValue() {
        
        let roundedDecimal: RoundedDecimal<Places.five> = "1.97647802"
        
        XCTAssertEqual(roundedDecimal.description, "1.97648")
    }
    
    func test_debugDescription_returnsCorrectValue() {
        
        let roundedDecimal: RoundedDecimal<Places.five> = "1.97647802"
        
        XCTAssertEqual(roundedDecimal.debugDescription, "1.97648")
    }
}
