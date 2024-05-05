//
//  SplashView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var isActive = true
    @State private var size = 0.6
    @State private var opacity = 0.3
    
    var body: some View {
        if (isActive) {
            VStack {
                Image(uiImage: UIImage(named: "logo")!)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 1.0
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                sessionManager.checkLoginStatus()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = false
                    }
                }
            }
        } else {
            if (sessionManager.isLoggedIn == true) {
                DashboardView()
                    .environmentObject(sessionManager)
            } else {
                LoginView()
                    .environmentObject(sessionManager)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(SessionManager())
}
