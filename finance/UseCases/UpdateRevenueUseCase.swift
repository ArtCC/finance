//
//  UpdateRevenueUseCase.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation

protocol UpdateRevenueProtocol {
    func updateRevenueWith(identifier: UUID, title: String, amount: String) throws
}

struct UpdateRevenueUseCase: UpdateRevenueProtocol {
    // MARK: - Properties

    var revenuesDatabase: RevenuesDatabaseProtocol

    // MARK: - Init

    init(revenuesDatabase: RevenuesDatabaseProtocol = RevenuesDatabase.shared) {
        self.revenuesDatabase = revenuesDatabase
    }

    // MARK: - Public

    func updateRevenueWith(identifier: UUID, title: String, amount: String) throws {
        try revenuesDatabase.update(identifier: identifier, title: title, amount: amount)
    }
}
