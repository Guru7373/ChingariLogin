//
//  ProfileView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @State var showLogoutAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                    .padding(.top, 8)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(sessionManager.getUserName() ?? "")
                        .font(.headline)
                    
                    Text(sessionManager.getEmailID() ?? "")
                        .font(.subheadline)
                    
                    Text(sessionManager.getPhoneNumber() ?? "")
                        .font(.subheadline)
                }
                .padding(.leading, 30)
                .padding(.top, 16)
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("Profile")
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
    ProfileView()
        .environmentObject(SessionManager())
}
