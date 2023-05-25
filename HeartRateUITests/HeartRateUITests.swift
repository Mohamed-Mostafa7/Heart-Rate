//
//  HeartRateUITests.swift
//  HeartRateUITests
//
//  Created by Mohamed Mostafa on 25/05/2023.
//

import XCTest

final class HeartRateUITests: XCTestCase {
    
    func testStartCheckingHeartRate() {
        let app = XCUIApplication()
        app.launch()
        
        // Given
        let startButton = app.buttons["Start"]
        let stopButton = app.buttons["Stop"]
//        let mainView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        // When
        startButton.tap()
        
        // Then
        XCTAssertTrue(stopButton.exists)
        
        sleep(5)
        
        // When
        stopButton.tap()
        
        // Then
//        XCTAssertEqual(mainView.backgroundColor, UIColor.darkGray)
        XCTAssertTrue(startButton.exists)
        XCTAssertNotEqual(startButton.colorWells, UIColor.white)
        
        
    }

    
}
