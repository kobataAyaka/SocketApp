//
//  ContentView.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    let udpClient = UDPClient(host: "127.0.0.1", port: 12345)
    let tcpClient = TCPClient(host: "127.0.0.1", port: 12346) // Port changed to avoid conflict
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Socket!")
            
            // UDP Button
            Button("Send UDP Message") {
                let message = "Hello UDP!"
                if let data = message.data(using: .utf8) {
                    udpClient.send(data: data)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // TCP Button
            Button("Send TCP Message") {
                let message = "Hello TCP!"
                if let data = message.data(using: .utf8) {
                    tcpClient.send(data: data)
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
