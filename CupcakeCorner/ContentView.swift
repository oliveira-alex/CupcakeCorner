//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Oliveira on 27/09/2021.
//

import SwiftUI

class User: ObservableObject, Codable {
	enum CodingKeys: CodingKey {
		case name
	}
	
	@Published var name = "Alex Oliveira"
	// When wrapped with @Published, a String doesn't conform to Codable anymore. It's required to add:
	// An enum conforming to CodingKey with a case for each wrapped property,
	// A custom initializer (decoder)
	// And a custom encoder function
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	}
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
