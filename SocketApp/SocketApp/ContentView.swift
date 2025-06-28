//
//  ContentView.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    // MARK: - Properties for UDP/TCP
    let udpClient = UDPClient(host: "127.0.0.1", port: 12345)
    let tcpClient = TCPClient(host: "127.0.0.1", port: 12346)

    // MARK: - Properties for WebSocket
    @StateObject private var webSocketClient = WebSocketClient()
    @State private var messageText: String = ""
    // Public Echo Server for testing
    private let webSocketURL = "wss://echo.websocket.events"

    var body: some View {
        VStack(spacing: 15) {
            Text("Socket Tester")
                .font(.largeTitle)

            // --- UDP/TCP Section ---
            GroupBox(label: Text("UDP & TCP")) {
                HStack(spacing: 20) {
                    Button("Send UDP") {
                        let message = "Hello UDP!"
                        if let data = message.data(using: .utf8) {
                            udpClient.send(data: data)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Send TCP") {
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
            }
            
            // --- WebSocket Section ---
            GroupBox(label: Text("WebSocket")) {
                VStack {
                    HStack {
                        Button(webSocketClient.isConnected ? "Disconnect" : "Connect") {
                            if webSocketClient.isConnected {
                                webSocketClient.disconnect()
                            } else {
                                webSocketClient.connect(urlString: webSocketURL)
                            }
                        }
                        .padding()
                        .background(webSocketClient.isConnected ? Color.red : Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Spacer()
                        
                        Text(webSocketClient.isConnected ? "Connected" : "Disconnected")
                            .foregroundColor(webSocketClient.isConnected ? .green : .red)
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(webSocketClient.receivedMessages, id: \.self) {
                                Text($0)
                                    .padding(2)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
                    
                    HStack {
                        TextField("Enter message", text: $messageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Send") {
                            webSocketClient.send(message: messageText)
                            messageText = ""
                        }
                        .disabled(!webSocketClient.isConnected)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


#Preview {
    ContentView()
}
