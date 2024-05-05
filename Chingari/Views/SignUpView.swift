//
//  SignUpView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    @Binding var isPresented: Bool
    
    @State private var isAllFieldsValid = false
    @State private var showAlert = false
    @State private var isSuccess = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Image(uiImage: UIImage(named: "logo")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom)
                
                // Name Textfield
                TextField("Name", text: $viewModel.name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Email Textfield
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Password Textfield
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Phone Number Textfield
                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                HStack {
                    Spacer()
                    Text("Provide a valid phone number without country code")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                // Sign Up Button
                Button(action: {
                    if (isAllFieldsValid) {
                        viewModel.signUp()
                        if viewModel.isSignedUp {
                            isSuccess = true
                        }
                    } else {
                        isSuccess = false
                    }
                    showAlert = true
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top)
                .alert(isPresented: $showAlert, content: {
                    if (isSuccess) {
                        Alert(title: Text("Success"), message: Text("Signed-up successfully"), dismissButton: .default(Text("OK"), action: {
                            isPresented = false
                        }))
                    } else {
                        Alert(title: Text("Invalid"), message: Text("Please check all fields"), dismissButton: .default(Text("OK")))
                    }
                })
            }
            
            VStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Text("Already have an account? Sign in")
                        .foregroundColor(.blue)
                        .padding(.top)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(viewModel.isAllFieldsValid) { enabled in
            isAllFieldsValid = enabled
        }
    }
}

#Preview {
    SignUpView(isPresented: .constant(false))
}
