//
//  RevenueTest.swift
//  financeTests
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

@testable import finance
import XCTest

final class RevenueTest: XCTestCase {
    func testRevenueInitialization() {
        // Given or Arrange
        let title = "Test Title"
        let amount = "1"
        let date = Date()

        // When or Act
        let revenue = Revenue(title: title, amount: amount, createdAt: date)

        // Then or Assert
        XCTAssertEqual(revenue.title, title, "Title should be equal to Test Title")
        XCTAssertEqual(revenue.amount, amount)
        XCTAssertEqual(revenue.createdAt, date)
    }
}
