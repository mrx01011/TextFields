//
//  TextFieldsUITests.swift
//  TextFieldsUITests
//
//  Created by Vladyslav Nhuien on 05.08.2022.
//

import XCTest

class TextFieldsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testMaskInput() throws {
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        let wwwwwDddddTextField = elementsQuery.textFields["wwwww-ddddd"]
        wwwwwDddddTextField.tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Text Fields").children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textField).element.typeText("a123")
        let result = elementsQuery.textFields["a"]
        
        XCTAssert(result.exists)
    }
    
    func testNoDigitsInput() throws {
        app.scrollViews.otherElements.containing(.staticText, identifier:"Text Fields").children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .textField).element.tap()
        app.scrollViews.otherElements.containing(.staticText, identifier:"Text Fields").children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .textField).element.typeText("Hell10o")
        
        let result = app.scrollViews.otherElements.textFields["Hello"]
        
        XCTAssert(result.exists)
    }
    
    func testLimitInput() throws {
        app.scrollViews.otherElements.containing(.staticText, identifier:"Text Fields").children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element.tap()
        app.scrollViews.otherElements.containing(.staticText, identifier:"Text Fields").children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element.typeText("123")
        
        let result = app.scrollViews.otherElements.staticTexts["7/10"]
        XCTAssert(result.exists)
    }
    
}
