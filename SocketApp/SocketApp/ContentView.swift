//
//  ContentView.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    let client = UDPClient(host: "127.0.0.1", port: 12345)
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Send UDP Message") {
                let message = "Hello UDP!"
                if let data = message.data(using: .utf8) {
                    client.send(data: data)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
