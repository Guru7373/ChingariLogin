//
//  ChingariApp.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

@main
struct ChingariApp: App {
    
    @StateObject private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(sessionManager)
                .preferredColorScheme(sessionManager.isDarkModeEnabled ? .dark : .light)
        }
    }
}
