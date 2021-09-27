//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alex Oliveira on 27/09/2021.
//

import SwiftUI

struct ContentView: View {
	@State var username = ""
	@State var email = ""
	
	var disableForm: Bool {
		username.count < 5 || email.count < 5
	}
	
    var body: some View {
		Form {
			Section {
				TextField("Username", text: $username)
				TextField("Email", text: $email)
			}
			
			Section {
				Button("Create account") {
					print("Creating account...")
				}
			}
			.disabled(disableForm)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
