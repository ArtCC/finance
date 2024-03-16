//
//  CreateRevenueUseCase.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation

protocol CreateRevenueProtocol {
    func createRevenueWith(title: String, amount: String) throws
}

struct CreateRevenueUseCase: CreateRevenueProtocol {
    // MARK: - Properties

    var revenuesDatabase: RevenuesDatabaseProtocol

    // MARK: - Init

    init(revenuesDatabase: RevenuesDatabaseProtocol = RevenuesDatabase.shared) {
        self.revenuesDatabase = revenuesDatabase
    }

    // MARK: - Public

    func createRevenueWith(title: String, amount: String) throws {
        let revenue: Revenue = .init(identifier: .init(), title: title, amount: amount, createdAt: .now)
        try revenuesDatabase.insert(revenue: revenue)
    }
}
