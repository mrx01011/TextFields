//
//  TextFieldsTests.swift
//  TextFieldsTests
//
//  Created by Vladyslav Nhuien on 05.08.2022.
//

import XCTest
@testable import TextFields

class TextFieldsTests: XCTestCase {
    
    var noDigitsManager: NoDigitsManager!
    var passwordManager: PasswordStrengthManager!
    var linkManager: LinkView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        noDigitsManager = NoDigitsManager()
        passwordManager = PasswordStrengthManager()
        linkManager = LinkView()
    }

    override func tearDownWithError() throws {
        noDigitsManager = nil
        passwordManager = nil
        linkManager = nil
        try super.tearDownWithError()
    }

    func testInputWithoutDigits() throws {
        let string = "Hello"
        let result = noDigitsManager.isNoDigit(inString: string)
        XCTAssertTrue(result)
    }
    
    func testInputWithDigits() throws {
        let string = "Hell0"
        let result = noDigitsManager.isNoDigit(inString: string)
        XCTAssertFalse(result)
    }

    func testPasswordStrength() throws {
        let containingRules = Set<ValidationRequiredRule>(ValidationRequiredRule.allCases)
        let strength: StrengthType = .veryStrong
        let result = passwordManager.getPasswordStrength(containingRules: containingRules)
        XCTAssertEqual(result, strength)
    }
    
    func testLink() throws {
        let link = "www.google.com"
        let result: () = linkManager.tryOpen(urlFromString: link)
        XCTAssertNotNil(result)
    }
}
