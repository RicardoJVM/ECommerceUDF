//
//  CartFeatureViewModel.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import Foundation
import Observation

@Observable
final class CartFeatureViewModel {
    private(set) var state = CartFeatureState()
    // Nuevo Estado = Reducer(Estado Actual, Acción)
    func send(_ action: CartFeatureAction) {
        switch action {
        case .onAppear:
            loadCartItems()
        case .itemUpdated(let updatedItem):
            // Sincroniza la mutación del hijo con el arreglo del padre
            if let index = state.items.firstIndex(where: { $0.id == updatedItem.id }) {
                state.items[index] = updatedItem
            }
        case .removeItemTapped(let id):
            state.items.removeAll(where: { $0.id == id })
        case .checkoutTapped:
            processCheckout()
        }
    }
    
    private func loadCartItems() {
        // Datos de prueba o llamada a Repositorio
        state.items = [
            CartItemState(id: "1", name: "AirPods Pro", unitPrice: 249.0, quantity: 1),
            CartItemState(id: "2", name: "Funda de Silicón", unitPrice: 49.0, quantity: 2)
        ]
    }
    
    private func processCheckout() {
        state.isProcessingCheckout = true
        Task {
            // Simulación de red
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                self.state.isProcessingCheckout = false
                self.state.items.removeAll()
            }
        }
    }
}
