//
//  ContentView.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import SwiftData
import SwiftUI

struct HomeContentView: View {
    // MARK: - Properties

    var viewModel: HomeViewModel = .init()

    @State var showCreateRevenue = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.revenues) { revenue in
                    NavigationLink(value: revenue) {
                        VStack(alignment: .leading) {
                            Text(revenue.title)
                                .foregroundStyle(.primary)
                            Text(revenue.amount)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        showCreateRevenue.toggle()
                    }, label: {
                        Label("Crear ingreso", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle())
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                }
            }
            .navigationTitle("Ingresos")
            .navigationDestination(for: Revenue.self, destination: { revenue in
                UpdateRevenueView(viewModel: viewModel,
                                  identifier: revenue.identifier,
                                  title: revenue.title,
                                  amount: revenue.amount)
            })
            .fullScreenCover(isPresented: $showCreateRevenue, content: {
                CreateRevenueView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    HomeContentView(viewModel: .init(revenues: [
        .init(title: "Nómina", amount: "1.000", createdAt: .now),
        .init(title: "Dividendos", amount: "500", createdAt: .now)
    ]))
}
