//
//  FetchAllRevenuesUseCase.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation

protocol FetchAllRevenuesProtocol {
    func fetchAll() throws -> [Revenue]
}

struct FetchAllRevenuesUseCase: FetchAllRevenuesProtocol {
    // MARK: - Properties

    var revenuesDatabase: RevenuesDatabaseProtocol

    // MARK: - Init

    init(revenuesDatabase: RevenuesDatabaseProtocol = RevenuesDatabase.shared) {
        self.revenuesDatabase = revenuesDatabase
    }

    // MARK: - Public

    func fetchAll() throws -> [Revenue] {
        try revenuesDatabase.fetchAll()
    }
}
