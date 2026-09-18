//
//  CartItemView.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import SwiftUI

struct CartItemView: View {
    @State var viewModel: CartItemViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.state.name).font(.headline)
                Text("$\(viewModel.state.unitPrice, specifier: "%.2f") c/u")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button("-") { viewModel.send(.decrementTapped) }
                    .buttonStyle(.bordered)
                
                Text("\(viewModel.state.quantity)")
                    .font(.headline)
                
                Button("+") { viewModel.send(.incrementTapped) }
                    .buttonStyle(.bordered)
            }
        }
        .padding(.vertical, 4)
    }
}
