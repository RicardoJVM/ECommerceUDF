//
//  CartItemViewModel.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import Foundation
import Observation

@Observable
final class CartItemViewModel {
    private(set) var state: CartItemState
    
    // Callback para notificar al padre cuando el estado cambia de forma relevante
    var onStateChanged: ((CartItemState) -> Void)?

    init(state: CartItemState) {
        self.state = state
    }

    func send(_ action: CartItemAction) {
        switch action {
        case .incrementTapped:
            state.quantity += 1
            onStateChanged?(state) // 📢 Avisa al padre
            
        case .decrementTapped:
            if state.quantity > 1 {
                state.quantity -= 1
                onStateChanged?(state) // 📢 Avisa al padre
            }
        }
    }
}
