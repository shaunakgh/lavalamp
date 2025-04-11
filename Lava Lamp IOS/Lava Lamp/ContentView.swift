//
//  ContentView.swift
//  Lava Lamp
//
//  Created by Shaunak Ghosh on 10/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("icmini")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
            Text("Welcome to Lava Lamp! To get started, simply add the 'Lava Lamp' widget to your screen.")
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
