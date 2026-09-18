//
//  CartFeatureState.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import Foundation

struct CartFeatureState: Equatable {
    var items: [CartItemState] = []
    var isProcessingCheckout: Bool = false
    var errorMessage: String? = nil
    
    var totalAmount: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }
}

enum CartFeatureAction {
    case onAppear
    case itemUpdated(CartItemState)
    case removeItemTapped(id: String)
    case checkoutTapped
}
