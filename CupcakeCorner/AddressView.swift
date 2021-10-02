//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Alex Oliveira on 29/09/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.items.name)
                TextField("Street Address", text: $order.items.streetAddress)
                TextField("City", text: $order.items.city)
                TextField("Zip", text: $order.items.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.items.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
