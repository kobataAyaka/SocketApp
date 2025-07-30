//
//  SocketAppApp.swift
//  SocketApp
//
//  Created by 小幡綾加 on 11/10/24.
//

import SwiftUI

@main
struct SocketAppApp: App {
    // swiftlint:disable:next weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
