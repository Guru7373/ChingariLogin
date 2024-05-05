//
//  SettingsView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @State var showLogoutAlert: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Appearance")) {
                HStack {
                    Image(systemName: "moon.fill")
                        .foregroundStyle(Color(.white))
                        .frame(width: 40, height: 40)
                        .background(Color(.black).opacity(0.8))
                        .cornerRadius(10)
                    Spacer()
                    Toggle("Dark Mode", isOn: $sessionManager.isDarkModeEnabled)
                }
            }
            
            Section(header: Text("Other Settings")) {
                HStack {
                    Image(systemName: "person")
                        .foregroundStyle(Color(.darkGray))
                        .frame(width: 40, height: 40)
                        .background(Color(.lightGray).opacity(0.5))
                        .cornerRadius(10)
                    Text("Security")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Image(systemName: "shield.checkered")
                        .foregroundStyle(Color(.darkGray))
                        .frame(width: 40, height: 40)
                        .background(Color(.lightGray).opacity(0.5))
                        .cornerRadius(10)
                    Text("Privacy")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Image(systemName: "questionmark")
                        .foregroundStyle(Color(.darkGray))
                        .frame(width: 40, height: 40)
                        .background(Color(.lightGray).opacity(0.5))
                        .cornerRadius(10)
                    Text("Help & Support")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Image(systemName: "face.smiling")
                        .foregroundStyle(Color(.darkGray))
                        .frame(width: 40, height: 40)
                        .background(Color(.lightGray).opacity(0.5))
                        .cornerRadius(10)
                    Text("Feedback")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            Button(action: {
                showLogoutAlert = true
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundStyle(.orange)
            })
            .alert(isPresented: $showLogoutAlert, content: {
                Alert(title: Text("Logout"),
                      message: Text("Are you sure, you want to logout ?"),
                      primaryButton: .destructive(Text("Yes"), action: {
                    sessionManager.setLoggedIn(status: false)
                }), secondaryButton: .default(Text("No")))
            })
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SessionManager())
}
