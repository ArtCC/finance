//
//  UpdateRevenueView.swift
//  finance
//
//  Created by Arturo Carretero Calvo on 16/3/24.
//

import SwiftUI

struct UpdateRevenueView: View {
    var viewModel: HomeViewModel

    let identifier: UUID

    @State var title = ""
    @State var amount = ""

    @Environment(\.dismiss) private  var dismiss

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Título"), axis: .vertical)
                    TextField("", text: $amount, prompt: Text("*Importe"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeRevenueWith(identifier: identifier)
                dismiss()
            }, label: {
                Text("Eliminar ingreso")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.updateRevenue(identifier: identifier, newTitle: title, newAmount: amount)
                    dismiss()
                } label: {
                    Text("Guardar")
                        .bold()
                }
            }
        }
        .navigationTitle("Modificar ingreso")
    }
}

#Preview {
    NavigationStack {
        UpdateRevenueView(viewModel: .init(), identifier: .init(), title: "", amount: "")
    }
}
