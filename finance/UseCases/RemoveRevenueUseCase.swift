//
//  RemoveRevenueUseCase.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation

protocol RemoveRevenueProtocol {
    func removeRevenueWith(identifier: UUID) throws
}

struct RemoveRevenueUseCase: RemoveRevenueProtocol {
    // MARK: - Properties

    var revenuesDatabase: RevenuesDatabaseProtocol

    // MARK: - Init

    init(revenuesDatabase: RevenuesDatabaseProtocol = RevenuesDatabase.shared) {
        self.revenuesDatabase = revenuesDatabase
    }

    // MARK: - Public

    func removeRevenueWith(identifier: UUID) throws {
        try revenuesDatabase.remove(identifier: identifier)
    }
}
