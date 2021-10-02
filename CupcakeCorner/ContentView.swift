//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Oliveira on 27/09/2021.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var order = Order()
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					Picker("Select your cake type", selection: $order.items.type) {
						ForEach(0..<OrderItems.types.count) {
							Text(OrderItems.types[$0])
						}
					}
//					.pickerStyle(SegmentedPickerStyle())
					
					Stepper(value: $order.items.quantity, in: 3...20) {
						Text("number of cakes: \(order.items.quantity)")
					}
				}
				
				Section {
					Toggle(isOn: $order.items.specialRequestEnabled.animation()) {
						Text("Any special requests?")
					}
					
					if order.items.specialRequestEnabled {
						Toggle(isOn: $order.items.extraFrosting) {
							Text("Add extra frosting")
						}
						
						Toggle(isOn: $order.items.addSprinkles) {
							Text("Add extra sprinkles")
						}
					}
				}
				
				Section {
					NavigationLink(destination: AddressView(order: order)) {
						Text("Delivery details")
					}
				}
			}
			.navigationBarTitle("Cupcake Corner")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
