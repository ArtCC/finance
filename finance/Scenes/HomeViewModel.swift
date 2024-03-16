//
//  HomeViewModel.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    // MARK: - Properties

    var revenues: [Revenue]
    var databaseError: DatabaseError?
    var createRevenueUseCase: CreateRevenueProtocol
    var fetchAllRevenuesUseCase: FetchAllRevenuesProtocol
    var updateRevenueUseCase: UpdateRevenueProtocol
    var removeRevenueUseCase: RemoveRevenueProtocol

    // MARK: - Init

    init(revenues: [Revenue] = [],
         createRevenueUseCase: CreateRevenueProtocol = CreateRevenueUseCase(),
         fetchAllRevenuesUseCase: FetchAllRevenuesProtocol = FetchAllRevenuesUseCase(),
         updateRevenueUseCase: UpdateRevenueProtocol = UpdateRevenueUseCase(),
         removeRevenueUseCase: RemoveRevenueProtocol = RemoveRevenueUseCase()) {
        self.revenues = revenues
        self.createRevenueUseCase = createRevenueUseCase
        self.fetchAllRevenuesUseCase = fetchAllRevenuesUseCase
        self.updateRevenueUseCase = updateRevenueUseCase
        self.removeRevenueUseCase = removeRevenueUseCase
        fetchAllRevenues()
    }

    // MARK: - Input

    func createRevenue(title: String, amount: String) {
        do {
            try createRevenueUseCase.createRevenueWith(title: title, amount: amount)
            fetchAllRevenues()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    func updateRevenue(identifier: UUID, newTitle: String, newAmount: String) {
        do {
            try updateRevenueUseCase.updateRevenueWith(identifier: identifier, title: newTitle, amount: newAmount)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    func removeRevenueWith(identifier: UUID) {
        do {
            try removeRevenueUseCase.removeRevenueWith(identifier: identifier)
            fetchAllRevenues()
        } catch let error as DatabaseError {
            print("Error \(error.localizedDescription)")
            databaseError = error
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    func fetchAllRevenues() {
        do {
            revenues = try fetchAllRevenuesUseCase.fetchAll()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}
