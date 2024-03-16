//
//  Mocks.swift
//  financeTests
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

@testable import finance
import Foundation

var mockDatabase: [Revenue] = []

struct CreateRevenueUseCaseMock: CreateRevenueProtocol {
    func createRevenueWith(title: String, amount: String) throws {
        let revenue = Revenue(title: title, amount: amount, createdAt: .now)
        mockDatabase.append(revenue)
    }
}

struct FetchAllRevenuesUseCaseMock: FetchAllRevenuesProtocol {
    func fetchAll() throws -> [Revenue] {
        return mockDatabase
    }
}

struct UpdateRevenueUseCaseMock: UpdateRevenueProtocol {
    func updateRevenueWith(identifier: UUID, title: String, amount: String) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase[index].title = title
            mockDatabase[index].amount = amount
        }
    }
}

struct RemoveRevenueUseCaseMock: RemoveRevenueProtocol {
    func removeRevenueWith(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase.remove(at: index)
        }
    }
}
