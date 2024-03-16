//
//  HomeViewModelIntegrationTests.swift
//  financeTests
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

@testable import finance
import XCTest

final class HomeViewModelIntegrationTests: XCTestCase {
    var sut: HomeViewModel!

    @MainActor
    override func setUpWithError() throws {
        let database = RevenuesDatabase.shared
        database.container = RevenuesDatabase.setupContainer(inMemory: true)

        let createRevenueUseCase = CreateRevenueUseCase(revenuesDatabase: database)
        let fetchAllRevenuesUseCase = FetchAllRevenuesUseCase(revenuesDatabase: database)

        sut = HomeViewModel(createRevenueUseCase: createRevenueUseCase,
                            fetchAllRevenuesUseCase: fetchAllRevenuesUseCase)
    }

    override func tearDownWithError() throws {
    }

    func testCreateRevenue() {
        // Given
        sut.createRevenue(title: "Hello 1", amount: "1")

        // When
        let revenue = sut.revenues.first

        // Then
        XCTAssertNotNil(revenue)
        XCTAssertEqual(revenue?.title, "Hello 1")
        XCTAssertEqual(revenue?.amount, "1")
        XCTAssertEqual(sut.revenues.count, 1, "Debería haber un ingreso en la base de datos")
    }

    func testCreateTwoRevenues() {
        // Given
        sut.createRevenue(title: "Hello 1", amount: "1")
        sut.createRevenue(title: "Hello 2", amount: "2")

        // When
        let firstRevenue = sut.revenues.first
        let lastRevenue = sut.revenues.last

        // Then
        XCTAssertNotNil(firstRevenue)
        XCTAssertEqual(firstRevenue?.title, "Hello 1")
        XCTAssertEqual(firstRevenue?.amount, "1")
        XCTAssertNotNil(lastRevenue)
        XCTAssertEqual(lastRevenue?.title, "Hello 2")
        XCTAssertEqual(lastRevenue?.amount, "2")

        XCTAssertEqual(sut.revenues.count, 2, "Debería haber 2 ingresos en la base de datos")
    }

    func testFetchAllRevenues() {
        // Given
        sut.createRevenue(title: "Hello 1", amount: "1")
        sut.createRevenue(title: "Hello 2", amount: "2")

        // When
        let firstRevenue = sut.revenues[0]
        let secondRevenue = sut.revenues[1]

        // Then
        XCTAssertEqual(sut.revenues.count, 2, "There should be two revenues in the database")
        XCTAssertEqual(firstRevenue.title, "Hello 1", "First revenue's title should be 'Revenue 1'")
        XCTAssertEqual(firstRevenue.amount, "1", "First revenue's text should be 'text 1'")
        XCTAssertEqual(secondRevenue.title, "Hello 2", "First revenue's title should be 'Revenue 2'")
        XCTAssertEqual(secondRevenue.amount, "2", "First revenue's text should be 'text 2'")
    }

    func testUpdateRevenue() {
        sut.createRevenue(title: "Revenue 1", amount: "1")

        guard let revenue = sut.revenues.first else {
            XCTFail("Revenue not exist")
            return
        }

        sut.updateRevenue(identifier: revenue.identifier, newTitle: "Revenue 2", newAmount: "2")
        sut.fetchAllRevenues()

        XCTAssertEqual(sut.revenues.count, 1, "Debería haber 1 ingreso en la base de datos")
        XCTAssertEqual(sut.revenues[0].title, "Revenue 2")
        XCTAssertEqual(sut.revenues[0].amount, "2")
    }

    func testRemoveRevenue() {
        sut.createRevenue(title: "Revenue 1", amount: "1")
        sut.createRevenue(title: "Revenue 2", amount: "2")
        sut.createRevenue(title: "Revenue 3", amount: "3")

        guard let revenue = sut.revenues.last else {
            XCTFail("Revenue not exist")
            return
        }

        sut.removeRevenueWith(identifier: revenue.identifier)
        XCTAssertEqual(sut.revenues.count, 2, "Debería haber 2 ingresos en la base de datos")
    }

    func testRemoveRevenueInDatabaseShouldThrowError() {
        sut.removeRevenueWith(identifier: UUID())

        XCTAssertEqual(sut.revenues.count, 0)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, DatabaseError.errorRemove)
    }
}
