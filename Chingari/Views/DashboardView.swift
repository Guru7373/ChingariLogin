//
//  TabView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
                    .environmentObject(sessionManager)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationView {
                ProfileView()
                    .environmentObject(sessionManager)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            
            NavigationView {
                SettingsView()
                    .environmentObject(sessionManager)
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        .accentColor(.orange)
    }
}

#Preview {
    DashboardView()
        .environmentObject(SessionManager())
}
