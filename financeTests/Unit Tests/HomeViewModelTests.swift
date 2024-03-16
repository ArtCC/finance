//
//  ViewModelTests.swift
//  financeTests
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

@testable import finance
import XCTest

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel(createRevenueUseCase: CreateRevenueUseCaseMock(),
                                  fetchAllRevenuesUseCase: FetchAllRevenuesUseCaseMock(),
                                  updateRevenueUseCase: UpdateRevenueUseCaseMock(),
                                  removeRevenueUseCase: RemoveRevenueUseCaseMock())
    }

    override func tearDownWithError() throws {
        mockDatabase = []
    }

    func testCreateRevenue() {
        // Given
        let title = "Test Title"
        let amount = "1"

        // When
        viewModel.createRevenue(title: title, amount: amount)

        // Then
        XCTAssertEqual(viewModel.revenues.count, 1)
        XCTAssertEqual(viewModel.revenues.first?.title, title)
        XCTAssertEqual(viewModel.revenues.first?.amount, amount)
    }

    func testCreateThreeRevenue() {
        // Given
        let title1 = "Test Title 1"
        let amount1 = "1"

        let title2 = "Test Title 2"
        let amount2 = "2"

        let title3 = "Test Title 3 "
        let amount3 = "3"

        // When
        viewModel.createRevenue(title: title1, amount: amount1)
        viewModel.createRevenue(title: title2, amount: amount2)
        viewModel.createRevenue(title: title3, amount: amount3)

        // Then
        XCTAssertEqual(viewModel.revenues.count, 3)
        XCTAssertEqual(viewModel.revenues.first?.title, title1)
        XCTAssertEqual(viewModel.revenues.first?.amount, amount1)
        XCTAssertEqual(viewModel.revenues[1].title, title2)
        XCTAssertEqual(viewModel.revenues[1].amount, amount2)
        XCTAssertEqual(viewModel.revenues[2].title, title3)
        XCTAssertEqual(viewModel.revenues[2].amount, amount3)
    }

    func testUpdateRevenue() {
        // Given
        let title = "Test Title"
        let amount = "1"

        viewModel.createRevenue(title: title, amount: amount)

        let newTitle = "New Title"
        let newAmount = "2"

        // When
        if let identifier = viewModel.revenues.first?.identifier {
            viewModel.updateRevenue(identifier: identifier, newTitle: newTitle, newAmount: newAmount)

            // Then
            XCTAssertEqual(viewModel.revenues.first?.title, newTitle)
            XCTAssertEqual(viewModel.revenues.first?.amount, newAmount)
        } else {
            XCTFail("No revenue was created.")
        }
    }

    func testRemoveRevenue() {
        // Given
        let title = "Test Title"
        let amount = "1"

        viewModel.createRevenue(title: title, amount: amount)

        if let identifier = viewModel.revenues.first?.identifier {
            // When
            viewModel.removeRevenueWith(identifier: identifier)

            // Then
            XCTAssertTrue(viewModel.revenues.isEmpty)
        } else {
            XCTFail("No revenue was created")
        }
    }
}
