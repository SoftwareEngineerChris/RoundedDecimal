import XCTest
@testable import RoundedDecimal

final class RoundedDecimalTests: XCTestCase {
    
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
    
    func test_equatable_variousDecimals_returnsTrue() {
        
        let decimalA: RoundedDecimal<Places.two> = "1.25"
        
        let decimalB: RoundedDecimal<Places.two> = "1.254"
        
        let decimalC: RoundedDecimal<Places.two> = "1.2545"
        
        let decimalD: RoundedDecimal<Places.two> = "1.250000"
        
        XCTAssertEqual(decimalA, decimalB)
        
        XCTAssertEqual(decimalA, decimalC)
        
        XCTAssertEqual(decimalA, decimalD)
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
    
    // MARK: format(with:)
    
    func test_formatWith_formatsCorrectly() {
        
        let decimalA: RoundedDecimal<Places.five> = "1.259456363"
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .spellOut
        
        let result = decimalA.format(with: numberFormatter)
        
        XCTAssertEqual(result, "one point two five nine four six")
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
    
    func test_debugDescription_NaN_returnsCorrectValue() {
        
        let roundedDecimal: RoundedDecimal<Places.five> = .nan()
        
        XCTAssertEqual(roundedDecimal.debugDescription, "NaN")
    }
    
    // MARK: Examples
    
    func test_dealingWithMultiplePrecisions_decreasingPrecision() {
        
        let listedUSDPrice: RoundedDecimal<Places.two> = "2.59"
        
        let exchangeRate: RoundedDecimal<Places.five> = "1.12345"
        
        let shortExchangeRate: RoundedDecimal<Places.two> = exchangeRate.withInferredPrecision()
        
        let localPrice = listedUSDPrice * shortExchangeRate
        
        XCTAssertEqual(localPrice, "2.90")
    }
    
    func test_dealingWithMultiplePrecisions_increasingPrecision() {
        
        let listedUSDPrice: RoundedDecimal<Places.two> = "2.59"
        
        let exchangeRate: RoundedDecimal<Places.five> = "1.12345"
        
        let longListedUSDPrice: RoundedDecimal<Places.five> = listedUSDPrice.withInferredPrecision()
        
        let localPrice = longListedUSDPrice * exchangeRate
        
        XCTAssertEqual(localPrice, "2.90974")
    }
    
    static var allTests = [
        ("test_initWithString_validDecimalString_returnsRoundedDecimal", test_initWithString_validDecimalString_returnsRoundedDecimal),
        ("test_initWithString_invalidDecimalString_returnsNil", test_initWithString_invalidDecimalString_returnsNil),
        ("test_initWithIntegerLiteral_returnsRoundedDecimal", test_initWithIntegerLiteral_returnsRoundedDecimal),
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
        ("test_codable_toAndFromSameType_equates", test_codable_toAndFromSameType_equates),
        ("test_codable_toLesserDecimalType_usesLesserTypeForRounding", test_codable_toLesserDecimalType_usesLesserTypeForRounding),
        ("test_codable_toGreaterDecimalType_retainsAccuracy", test_codable_toGreaterDecimalType_retainsAccuracy),
        ("test_encodable_representedAsRootLevelString", test_encodable_representedAsRootLevelString),
        ("test_description_returnsCorrectValue", test_description_returnsCorrectValue),
        ("test_debugDescription_returnsCorrectValue", test_debugDescription_returnsCorrectValue),
        ("test_debugDescription_NaN_returnsCorrectValue", test_debugDescription_NaN_returnsCorrectValue),
        ("test_dealingWithMultiplePrecisions_decreasingPrecision", test_dealingWithMultiplePrecisions_decreasingPrecision),
        ("test_dealingWithMultiplePrecisions_increasingPrecision", test_dealingWithMultiplePrecisions_increasingPrecision),
    ]
}
