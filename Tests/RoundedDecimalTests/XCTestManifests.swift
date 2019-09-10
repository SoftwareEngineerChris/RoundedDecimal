//
//  XCTestManifests.swift
//  RoundedDecimal
//
//  Created by Chris Hargreaves on 09/09/2019.
//  Copyright © 2019 Software Engineering Limited. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RoundedDecimalTests.allTests),
    ]
}
#endif
