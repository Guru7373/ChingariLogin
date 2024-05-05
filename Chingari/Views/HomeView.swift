//
//  HomeView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @State var showLogoutAlert: Bool = false
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                if let videoUrl = post.videoUrl {
                    VideoPlayer(player: AVPlayer(url: videoUrl))
                        .frame(height: 200)
                        .cornerRadius(10)
                } else {
                    if let imageUrl = post.imageUrl {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                            default:
                                ProgressView()
                                    .frame(height: 200)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.subtitle)
                        .font(.subheadline)
                }
                .padding(.leading, 8)
                .padding(.bottom, 16)
            }
            .frame(width: UIScreen.main.bounds.width - 40)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .navigationTitle("Home")
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
    HomeView()
        .environmentObject(SessionManager())
}
