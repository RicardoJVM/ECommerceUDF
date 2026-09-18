//
//  CartItemState.swift
//  ECommerceUDF
//
//  Created by Ricardo Valencia on 18/9/26.
//

import Foundation

struct CartItemState: Identifiable, Equatable {
    let id: String
    let name: String
    let unitPrice: Double
    var quantity: Int
    
    var subtotal: Double {
        Double(quantity) * unitPrice
    }
}

enum CartItemAction {
    case incrementTapped
    case decrementTapped
}
