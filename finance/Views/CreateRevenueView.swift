//
//  CreateRevenueView.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import SwiftUI

struct CreateRevenueView: View {
    var viewModel: HomeViewModel

    @State var title = ""
    @State var amount = ""

    @Environment(\.dismiss) private  var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $amount, prompt: Text("*Importe"), axis: .vertical)
                } footer: {
                    Text("* El título es obligatorio")
                        .foregroundStyle(.red)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                    }
                }

                ToolbarItem {
                    Button {
                        viewModel.createRevenue(title: title, amount: amount)
                        dismiss()
                    } label: {
                        Text("Crear ingreso")
                            .bold()
                    }
                }
            }
            .navigationTitle("Nuevo ingreso")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateRevenueView(viewModel: .init())
}
