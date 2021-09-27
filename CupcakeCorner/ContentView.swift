//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Oliveira on 27/09/2021.
//

import SwiftUI

struct Response: Codable {
	var results: [Result]
}

struct Result: Codable {
	var trackId: Int
	var trackName: String
	var collectionName: String
}

struct ContentView: View {
	@State var results = [Result]()
	@State var artistName = ""
	var cleanedArtistName: String {
		artistName.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
	}
	
	var body: some View {
		NavigationView {
			VStack {
				TextField("Artist Name", text: $artistName, onCommit: loadData)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.padding()
					.onTapGesture { artistName = "" }
				
				List(results, id:\.trackId) { item in
					VStack(alignment: .leading) {
						Text(item.trackName)
							.font(.headline)
						
						Text(item.collectionName)
					}
				}
	//			.onAppear(perform: loadData)
			}
			.navigationTitle(Text("All The Songs"))
		}
	}
	
	func loadData() {
		guard let url = URL(string: "https://itunes.apple.com/search?term=\(cleanedArtistName)&entity=song") else {
			print("Invalid URL")
			artistName = "Invalid URL"
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
					DispatchQueue.main.async {
						self.results = decodedResponse.results
					}
					
					return
				}
			}
			
			print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			artistName = "Fetch failed: \(error?.localizedDescription ?? "Unknown error")"
		}.resume()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
