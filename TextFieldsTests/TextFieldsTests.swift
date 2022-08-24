//
//  TextFieldsTests.swift
//  TextFieldsTests
//
//  Created by Vladyslav Nhuien on 05.08.2022.
//

import XCTest
@testable import TextFields

class TextFieldsTests: XCTestCase {

    var mainVC: MainViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mainVC = MainViewController()
    }

    override func tearDownWithError() throws {
        mainVC = nil
        try super.tearDownWithError()

    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
