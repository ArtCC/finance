//
//  Revenue.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import Foundation
import SwiftData

@Model
final class Revenue: Identifiable, Hashable {
    // MARK: - Properties

    @Attribute(.unique) var identifier: UUID

    var title: String
    var amount: String

    let createdAt: Date

    // MARK: - Init

    init(identifier: UUID = UUID(), title: String, amount: String, createdAt: Date) {
        self.identifier = identifier
        self.title = title
        self.amount = amount
        self.createdAt = createdAt
    }
}
