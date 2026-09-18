//
//  CartFeatureView.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import SwiftUI

struct CartFeatureView: View {
    @State private var viewModel = CartFeatureViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.state.items.isEmpty {
                    ContentUnavailableView("Tu carrito está vacío", systemImage: "cart")
                } else {
                    List {
                        ForEach(viewModel.state.items) { itemState in
                            // Creamos el VM del hijo y nos suscribimos a los cambios
                            let itemVM = CartItemViewModel(state: itemState)
                            
                            CartItemView(viewModel: itemVM)
                                .onAppear {
                                    itemVM.onStateChanged = { updatedItem in
                                        viewModel.send(.itemUpdated(updatedItem))
                                    }
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.send(.removeItemTapped(id: itemState.id))
                                    } label: {
                                        Label("Eliminar", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    
                    // Footer del Padre
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total:").font(.title2).bold()
                            Spacer()
                            Text("$\(viewModel.state.totalAmount, specifier: "%.2f")")
                                .font(.title2).bold()
                        }
                        
                        Button(action: { viewModel.send(.checkoutTapped) }) {
                            if viewModel.state.isProcessingCheckout {
                                ProgressView().tint(.white)
                            } else {
                                Text("Pagar Ahora")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(viewModel.state.isProcessingCheckout)
                    }
                    .padding()
                }
            }
            .navigationTitle("Carrito")
            .onAppear { viewModel.send(.onAppear) }
        }
    }
}
