//
//  RevenuesDatabase.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol RevenuesDatabaseProtocol {
    func insert(revenue: Revenue) throws
    func fetchAll() throws -> [Revenue]
    func update(identifier: UUID, title: String, amount: String) throws
    func remove(identifier: UUID) throws
}

class RevenuesDatabase: RevenuesDatabaseProtocol {
    // MARK: - Properties

    static let shared = RevenuesDatabase()

    @MainActor

    var container: ModelContainer = setupContainer(inMemory: false)

    // MARK: - Init

    private init() {
    }

    // MARK: - Public

    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Revenue.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print("Error \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }

    @MainActor
    func insert(revenue: Revenue) throws {
        container.mainContext.insert(revenue)

        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }

    @MainActor
    func fetchAll() throws -> [Revenue] {
        let fetchDescriptor = FetchDescriptor<Revenue>(sortBy: [SortDescriptor<Revenue>(\.createdAt)])

        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }

    @MainActor
    func update(identifier: UUID, title: String, amount: String) throws {
        let revenuePredicate = #Predicate<Revenue> {
            $0.identifier == identifier
        }

        var fetchDescriptor = FetchDescriptor<Revenue>(predicate: revenuePredicate)
        fetchDescriptor.fetchLimit = 1

        do {
            guard let updateRevenue = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }

            updateRevenue.title = title
            updateRevenue.amount = amount

            try container.mainContext.save()
        } catch {
            print("Error actualizando información")
            throw DatabaseError.errorUpdate
        }
    }

    @MainActor
    func remove(identifier: UUID) throws {
        let revenuePredicate = #Predicate<Revenue> {
            $0.identifier == identifier
        }

        var fetchDescriptor = FetchDescriptor<Revenue>(predicate: revenuePredicate)
        fetchDescriptor.fetchLimit = 1

        do {
            guard let deleteRevenue = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorRemove
            }

            container.mainContext.delete(deleteRevenue)
            try container.mainContext.save()
        } catch {
            print("Error actualizando información")
            throw DatabaseError.errorRemove
        }
    }
}
