
//
//  WebSocketClient.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import Foundation
import Combine

class WebSocketClient: NSObject, ObservableObject, URLSessionWebSocketDelegate {
    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!
    
    @Published var receivedMessages: [String] = []
    @Published var isConnected: Bool = false
    
    override init() {
        super.init()
        // Initialize the URLSession with this class as the delegate
        self.urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }
    
    func connect(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: invalid URL")
            return
        }
        
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        // The connection status will be updated by the delegate methods
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func send(message: String) {
        guard isConnected else {
            print("Cannot send message, not connected.")
            return
        }
        
        webSocketTask?.send(.string(message)) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error sending message: \(error)")
                    self.receivedMessages.append("Send Error: \(error.localizedDescription)")
                } else {
                    self.receivedMessages.append("Sent: \(message)")
                }
            }
        }
    }
    
    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
                DispatchQueue.main.async {
                    // Avoid showing an error if we disconnected gracefully
                    if self.isConnected {
                        self.receivedMessages.append("Receive Error: \(error.localizedDescription)")
                    }
                    self.isConnected = false
                }
            case .success(let message):
                DispatchQueue.main.async {
                    switch message {
                    case .string(let text):
                        print("Received string: \(text)")
                        self.receivedMessages.append("Received: \(text)")
                    case .data(let data):
                        print("Received data: \(data)")
                        self.receivedMessages.append("Received: \(data.count) bytes")
                    @unknown default:
                        fatalError()
                    }
                }
                // Continue listening for the next message
                self.listenForMessages()
            }
        }
    }
    
    // MARK: - URLSessionWebSocketDelegate Methods
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket did connect")
        DispatchQueue.main.async {
            self.isConnected = true
            self.receivedMessages.append("Connected.")
        }
        listenForMessages()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("WebSocket did disconnect")
        DispatchQueue.main.async {
            self.isConnected = false
            if let error = error {
                self.receivedMessages.append("Disconnected with error: \(error.localizedDescription)")
            } else {
                // Only show "Disconnected." if there wasn't a more specific error
                if self.receivedMessages.last?.contains("Error") == false {
                     self.receivedMessages.append("Disconnected.")
                }
            }
        }
    }
}
