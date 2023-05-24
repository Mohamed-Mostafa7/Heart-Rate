//
//  HeartCaseTests.swift
//  HeartRateTests
//
//  Created by Mohamed Mostafa on 24/05/2023.
//

import XCTest
@testable import Heart_Rate

final class HeartCaseTests: XCTestCase {
    
    var heartCase: HeartCase?
    
    override func setUpWithError() throws {
        
        heartCase = HeartCase()
    }

    override func tearDownWithError() throws {
        
        heartCase = nil
    }
    
    func testGetHeartCase() {
        // Given
        let heartSpeed = HeartSpeed.slow
        
        // When
        let result = heartCase?.getHeartCase(heartSpeed)
        
        // Then
        XCTAssertEqual(result, Heart(background: .yellow, message: "Slow Heart Rate!", timeForBeat: 2))
    }

}
