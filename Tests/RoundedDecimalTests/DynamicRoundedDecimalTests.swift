//
//  DynamicRoundedDecimalTests.swift
//  RoundedDecimal
//
//  Created by Chris Hargreaves on 16/09/2018.
//  Copyright © 2018 Software Engineering Limited. All rights reserved.
//

import XCTest
@testable import RoundedDecimal

final class DynamicRoundedDecimalTests: XCTestCase {
    
    // MARK: Initialisers
    
    func test_initWithString_validDecimalString_returnsDynamicRoundedDecimal() {
        
        let decimal = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        XCTAssertEqual(decimal.description, "1.25")
        
        XCTAssertFalse(decimal.isNaN)
    }
    
    func test_initWithString_invalidDecimalString_returnsNil() {
        
        let decimal = DynamicRoundedDecimal(stringLiteral: "a1.25", scale: 2)
        
        XCTAssertTrue(decimal.isNaN)
    }
    
    func test_initWithIntegerLiteral_returnsDynamicRoundedDecimal() {
        
        let decimal: DynamicRoundedDecimal = 163
        
        XCTAssertNotNil(decimal)
        
        XCTAssertEqual(decimal.description, "163")
    }
    
    func test_initWithRoundedDecimal_returnsDynamicRoundedDecimal() {
        
        let roundedDecimal = RoundedDecimal<Places.four>(value: 1.284726)
        
        let decimal = DynamicRoundedDecimal(roundedDecimal: roundedDecimal, scale: 2)
        
        XCTAssertEqual(decimal.description, "1.28")
    }
    
    func test_initWithDynmicRoundedDecimal_returnsDynamicRoundedDecimal() {
        
        let dynamicRoundedDecimal = DynamicRoundedDecimal(stringLiteral: "1.274228", scale: 3)
        
        XCTAssertEqual(dynamicRoundedDecimal.description, "1.274")
        
        let decimal = DynamicRoundedDecimal(roundedDecimal: dynamicRoundedDecimal, scale: 2)
        
        XCTAssertEqual(decimal.description, "1.27")
    }
    
    // MARK: with(scale:)
    
    func test_withScale_toLesserScale_returnsDynamicRoundedDecimalWithNewScale() {
        
        let dynamicRoundedDecimal = DynamicRoundedDecimal(stringLiteral: "1.274228", scale: 4)
        
        let result = dynamicRoundedDecimal.with(scale: 2)
        
        XCTAssertEqual(result.description, "1.27")
    }
    
    func test_withScale_toGreaterScale_returnsDynamicRoundedDecimalWithNewScale() {
        
        let dynamicRoundedDecimal = DynamicRoundedDecimal(stringLiteral: "1.2742", scale: 4)
        
        let result = dynamicRoundedDecimal.with(scale: 6)
        
        XCTAssertEqual(result.description, "1.274200")
    }
    
    // MARK: Equatable
    
    func test_equatable_isEqual_returnsTrue() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        XCTAssertEqual(decimalA, decimalB)
    }
    
    func test_equatable_isNotEqual_returnsFalse() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.26", scale: 2)
        
        XCTAssertNotEqual(decimalA, decimalB)
    }
    
    func test_equatable_roundsToSameValue_returnsTrue() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.251", scale: 2)
        
        XCTAssertEqual(decimalA, decimalB)
    }
    
    func test_equatable_roundsToDifferentValue_returnsFalse() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.259", scale: 2)
        
        XCTAssertNotEqual(decimalA, decimalB)
    }
    
    func test_equatable_variousDecimals_returnsTrue() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 5)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.254", scale: 2)
        
        let decimalC = DynamicRoundedDecimal(stringLiteral: "1.2545", scale: 2)
        
        let decimalD = DynamicRoundedDecimal(stringLiteral: "1.250000", scale: 10)
        
        XCTAssertEqual(decimalA, decimalB)
        
        XCTAssertEqual(decimalA, decimalC)
        
        XCTAssertEqual(decimalA, decimalD)
        
        XCTAssertEqual(decimalA.description, "1.25000")
        
        XCTAssertEqual(decimalB.description, "1.25")
        
        XCTAssertEqual(decimalC.description, "1.25")
        
        XCTAssertEqual(decimalD.description, "1.2500000000")
    }
    
    // MARK: Comparable
    
    func test_comparable_lessThan_lhsLessThanRhs_returnsTrue() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.26", scale: 2)
        
        XCTAssertTrue(decimalA < decimalB)
    }
    
    func test_comparable_lessThan_lhsGreaterThanRhs_returnsFalse() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.26", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        XCTAssertFalse(decimalA < decimalB)
    }
    
    func test_comparable_greaterThan_lhsLessThanRhs_returnsFalse() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.26", scale: 2)
        
        XCTAssertFalse(decimalA > decimalB)
    }
    
    func test_comparable_greaterThan_lhsGreaterThanRhs_returnsTrue() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.26", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        XCTAssertTrue(decimalA > decimalB)
    }
    
    // MARK: Arithmetic
    
    func test_addition_addsCorrectly() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "7.76", scale: 2)
        
        let result = decimalA + decimalB
        
        XCTAssertEqual(result.description, "9.01")
    }
    
    func test_subtraction_subtractsCorrectly() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "7.76", scale: 2)
        
        let result = decimalA - decimalB

        XCTAssertEqual(result.description, "-6.51")
    }
    
    func test_division_dividesCorrectly() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "7.76", scale: 2)
        
        let result = decimalA / decimalB
        
        XCTAssertEqual(result.description, "0.16")
    }
    
    func test_division_fromZero_dividesCorrectly_zero() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "0", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "7.76", scale: 2)
        
        let result = decimalA / decimalB
        
        XCTAssertEqual(result.description, "0.00")
        
        XCTAssertFalse(result.isNaN)
    }
    
    func test_division_byZero_isNaN() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "0", scale: 2)
        
        let result = decimalA / decimalB
        
        XCTAssertEqual(result.description, "NaN")
        
        XCTAssertTrue(result.isNaN)
    }
    
    func test_multiplication_multipliesCorrectly() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "7.76", scale: 2)
        
        let result = decimalA * decimalB
        
        XCTAssertEqual(result.description, "9.70")
    }
    
    func test_multiplication_byZero_multipliesCorrectly_zero() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB = DynamicRoundedDecimal(stringLiteral: "0", scale: 2)
        
        let result = decimalA * decimalB

        XCTAssertEqual(result.description, "0.00")
    }
    
    func test_precidence_bodmas1() {
        
        let result: DynamicRoundedDecimal = 30 - 2 * 5
        
        XCTAssertEqual(result, 20)
    }
    
    func test_precidence_bodmas2() {
        
        let result: DynamicRoundedDecimal = 20 + 21 / 3 * 2
        
        XCTAssertEqual(result, 34)
    }
    
    // MARK: withInferredPrecision
    
    func test_withInferredPrecision_smallerToLargerNumberOfPlaces_retainsAccuracyAndPrecision() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25", scale: 2)
        
        let decimalB: RoundedDecimal<Places.five> = decimalA.withInferredPrecision()
        
        let expectedDecimal: RoundedDecimal<Places.five> = "1.25000"
        
        XCTAssertEqual(decimalB, expectedDecimal)
        
        XCTAssertEqual(decimalB.description, "1.25000")
    }
    
    func test_withInferredPrecision_largerToSmallerNumberOfPlaces_losesPrecisionRatainsAccuracy() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.25900", scale: 5)
        
        let decimalB: RoundedDecimal<Places.two> = decimalA.withInferredPrecision()
        
        let expectedDecimal:RoundedDecimal<Places.two> = "1.26"
        
        XCTAssertEqual(decimalB, expectedDecimal)
        
        XCTAssertEqual(decimalB.description, "1.26")
    }
    
    // MARK: format(with:)
    
    func test_formatWith_formatsCorrectly() {
        
        let decimalA = DynamicRoundedDecimal(stringLiteral: "1.259456363", scale: 5)
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .spellOut
        
        let result = decimalA.format(with: numberFormatter)
        
        XCTAssertEqual(result, "one point two five nine four six")
    }
    
    // MARK: isNaN
    
    func test_isNaN_validNumber_returnsFalse() {
        
        let result: DynamicRoundedDecimal = 10 / 2
        
        XCTAssertEqual(result, 5)
        
        XCTAssertFalse(result.isNaN)
    }
    
    func test_isNaN_invalidNumber_returnsTrue() {
        
        let result: DynamicRoundedDecimal = 10 / 0
        
        XCTAssertTrue(result.isNaN)
    }
    
    // MARK: CustomStringConvertible, CustomDebugStringConvertible
    
    func test_description_returnsCorrectValue() {
        
        let roundedDecimal = DynamicRoundedDecimal(stringLiteral: "1.97647802", scale: 5)
        
        XCTAssertEqual(roundedDecimal.description, "1.97648")
    }
    
    func test_debugDescription_returnsCorrectValue() {
        
        let roundedDecimal = DynamicRoundedDecimal(stringLiteral: "1.97647802", scale: 5)
        
        XCTAssertEqual(roundedDecimal.debugDescription, "1.97648")
    }
    
    func test_debugDescription_NaN_returnsCorrectValue() {
        
        let roundedDecimal = DynamicRoundedDecimal(stringLiteral: "u1", scale: 5)
        
        XCTAssertEqual(roundedDecimal.debugDescription, "NaN")
    }
    
    // MARK: Examples
    
    func test_dealingWithMultiplePrecisions_shouldKeepGreatestPrecision() {
        
        let listedUSDPrice = DynamicRoundedDecimal(stringLiteral: "2.59", scale: 2)
        
        let exchangeRate = DynamicRoundedDecimal(stringLiteral: "1.12345", scale: 5)
        
        let localPrice = listedUSDPrice * exchangeRate
        
        XCTAssertEqual(localPrice.description, "2.90974")
    }
    
    func test_dealingWithMultiplePrecisions_operationInverted_shouldKeepGreatestPrecision() {
       
        let listedUSDPrice = DynamicRoundedDecimal(stringLiteral: "2.59", scale: 2)
        
        let exchangeRate = DynamicRoundedDecimal(stringLiteral: "1.12345", scale: 5)
        
        let localPrice = listedUSDPrice * exchangeRate
        
        XCTAssertEqual(localPrice.description, "2.90974")
    }
    
    static var allTests = [
        ("test_initWithString_validDecimalString_returnsDynamicRoundedDecimal", test_initWithString_validDecimalString_returnsDynamicRoundedDecimal),
        ("test_initWithString_invalidDecimalString_returnsNil", test_initWithString_invalidDecimalString_returnsNil),
        ("test_initWithIntegerLiteral_returnsDynamicRoundedDecimal", test_initWithIntegerLiteral_returnsDynamicRoundedDecimal),
        ("test_initWithRoundedDecimal_returnsDynamicRoundedDecimal", test_initWithRoundedDecimal_returnsDynamicRoundedDecimal),
        ("test_initWithDynmicRoundedDecimal_returnsDynamicRoundedDecimal", test_initWithDynmicRoundedDecimal_returnsDynamicRoundedDecimal),
        ("test_withScale_toLesserScale_returnsDynamicRoundedDecimalWithNewScale", test_withScale_toLesserScale_returnsDynamicRoundedDecimalWithNewScale),
        ("test_withScale_toGreaterScale_returnsDynamicRoundedDecimalWithNewScale", test_withScale_toGreaterScale_returnsDynamicRoundedDecimalWithNewScale),
        ("test_equatable_isEqual_returnsTrue", test_equatable_isEqual_returnsTrue),
        ("test_equatable_isNotEqual_returnsFalse", test_equatable_isNotEqual_returnsFalse),
        ("test_equatable_roundsToSameValue_returnsTrue", test_equatable_roundsToSameValue_returnsTrue),
        ("test_equatable_roundsToDifferentValue_returnsFalse", test_equatable_roundsToDifferentValue_returnsFalse),
        ("test_equatable_variousDecimals_returnsTrue", test_equatable_variousDecimals_returnsTrue),
        ("test_comparable_lessThan_lhsLessThanRhs_returnsTrue", test_comparable_lessThan_lhsLessThanRhs_returnsTrue),
        ("test_comparable_lessThan_lhsGreaterThanRhs_returnsFalse", test_comparable_lessThan_lhsGreaterThanRhs_returnsFalse),
        ("test_comparable_greaterThan_lhsLessThanRhs_returnsFalse", test_comparable_greaterThan_lhsLessThanRhs_returnsFalse),
        ("test_comparable_greaterThan_lhsGreaterThanRhs_returnsTrue", test_comparable_greaterThan_lhsGreaterThanRhs_returnsTrue),
        ("test_addition_addsCorrectly", test_addition_addsCorrectly),
        ("test_subtraction_subtractsCorrectly", test_subtraction_subtractsCorrectly),
        ("test_division_dividesCorrectly", test_division_dividesCorrectly),
        ("test_division_fromZero_dividesCorrectly_zero", test_division_fromZero_dividesCorrectly_zero),
        ("test_division_byZero_isNaN", test_division_byZero_isNaN),
        ("test_multiplication_multipliesCorrectly", test_multiplication_multipliesCorrectly),
        ("test_multiplication_byZero_multipliesCorrectly_zero", test_multiplication_byZero_multipliesCorrectly_zero),
        ("test_precidence_bodmas1", test_precidence_bodmas1),
        ("test_precidence_bodmas2", test_precidence_bodmas2),
        ("test_withInferredPrecision_smallerToLargerNumberOfPlaces_retainsAccuracyAndPrecision", test_withInferredPrecision_smallerToLargerNumberOfPlaces_retainsAccuracyAndPrecision),
        ("test_withInferredPrecision_largerToSmallerNumberOfPlaces_losesPrecisionRatainsAccuracy", test_withInferredPrecision_largerToSmallerNumberOfPlaces_losesPrecisionRatainsAccuracy),
        ("test_formatWith_formatsCorrectly", test_formatWith_formatsCorrectly),
        ("test_isNaN_validNumber_returnsFalse", test_isNaN_validNumber_returnsFalse),
        ("test_isNaN_invalidNumber_returnsTrue", test_isNaN_invalidNumber_returnsTrue),
        ("test_description_returnsCorrectValue", test_description_returnsCorrectValue),
        ("test_debugDescription_returnsCorrectValue", test_debugDescription_returnsCorrectValue),
        ("test_debugDescription_NaN_returnsCorrectValue", test_debugDescription_NaN_returnsCorrectValue),
        ("test_dealingWithMultiplePrecisions_shouldKeepGreatestPrecision", test_dealingWithMultiplePrecisions_shouldKeepGreatestPrecision),
        ("test_dealingWithMultiplePrecisions_operationInverted_shouldKeepGreatestPrecision", test_dealingWithMultiplePrecisions_operationInverted_shouldKeepGreatestPrecision),
    ]
}
