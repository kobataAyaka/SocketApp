//
//  UDPClient.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import Foundation
import Network

class UDPClient {
    private var connection: NWConnection?

    init(host: String, port: UInt16) {
        let host = NWEndpoint.Host(host)
        let port = NWEndpoint.Port(rawValue: port)!
        connection = NWConnection(host: host, port: port, using: .udp)
        connection?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("Connected to \(host)")
            case .failed(let error):
                print("Failed to connect: \(error)")
            default:
                break
            }
        }
        connection?.start(queue: .main)
    }

    func send(data: Data) {
        connection?.send(content: data, completion: .contentProcessed { error in
            if let error = error {
                print("Send error: \(error)")
            } else {
                print("Data sent")
            }
        })
    }

    func receive() {
        connection?.receiveMessage { data, _, isComplete, error in
            if let data = data, isComplete {
                print("Received data: \(data)")
            } else if let error = error {
                print("Receive error: \(error)")
            }
        }
    }

    func stop() {
        connection?.cancel()
    }
}
