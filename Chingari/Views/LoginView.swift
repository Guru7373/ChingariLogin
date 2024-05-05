//
//  LoginView.swift
//  Chingari
//
//  Created by Guru on 04/05/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var isSignUpViewPresented = false
    
    @State private var isAllFieldsValid = false
    @State private var showInvalidAlert = false
    @State private var isOTPSheetPresented = false
    @State private var isOTPValid = false
    @State private var showInvalidUserAlert = false
    @State private var showInvalidPasswordAlert = false
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                VStack {
                    Image(uiImage: UIImage(named: "logo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding(.bottom)
                    
                    Text("Provide your Email ID or Phone Number to get started")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    
                    // Password Textfield
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    
                    Text("OR")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .font(.caption)
                        .frame(height: 20)
                    
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
                    .padding(.bottom, 30)
                    
                    Button(action: {
                        if (isAllFieldsValid) {
                            viewModel.login(sessionManager: sessionManager)
                            if (viewModel.isLoggedIn) {
                                if !(viewModel.phoneNumber.isEmpty) {
                                    isOTPSheetPresented = true
                                } else {
                                    if !(viewModel.email.isEmpty) {
                                        withAnimation {
                                            sessionManager.setLoggedIn(status: true)
                                        }
                                    }
                                }
                            } else if (viewModel.userExists == false) {
                                showInvalidUserAlert = true
                                showInvalidAlert = true
                            } else if (viewModel.passwordMatched == false) {
                                showInvalidPasswordAlert = true
                                showInvalidAlert = true
                            }
                        } else {
                            showInvalidAlert = true
                        }
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    .alert(isPresented: $showInvalidAlert, content: {
                        if (showInvalidUserAlert) {
                            Alert(title: Text("Invalid"), message: Text("User not found"), dismissButton: .default(Text("OK")))
                        } else if (showInvalidPasswordAlert) {
                            Alert(title: Text("Invalid"), message: Text("Email or password is invalid"), dismissButton: .default(Text("OK")))
                        } else {
                            Alert(title: Text("Invalid"), message: Text("Enter valid email and password or a valid Phone Number"), dismissButton: .default(Text("OK")))
                        }
                    })
                    .fullScreenCover(isPresented: $isOTPSheetPresented, content: {
                        OTPView(isPresented: $isOTPSheetPresented,
                                phoneNumber: $viewModel.phoneNumber,
                                isValid: $isOTPValid)
                    })
                    .allowsHitTesting(true)
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        isSignUpViewPresented = true
                    }) {
                        Text("Don't have an account? Sign up")
                            .foregroundColor(.blue)
                            .padding(.top)
                    }
                }
            }
            .navigationBarHidden(true)
            .onReceive(viewModel.isAllFieldsValid, perform: { enabled in
                isAllFieldsValid = enabled
            })
            .fullScreenCover(isPresented: $isSignUpViewPresented, content: {
                withAnimation {
                    SignUpView(isPresented: $isSignUpViewPresented)
                }
            })
            .allowsHitTesting(true)
            .onChange(of: viewModel.email) { oldValue, newValue in
                if !newValue.isEmpty {
                    viewModel.phoneNumber = ""
                }
            }
            .onChange(of: viewModel.password) { oldValue, newValue in
                if !newValue.isEmpty {
                    viewModel.phoneNumber = ""
                }
            }
            .onChange(of: viewModel.phoneNumber) { oldValue, newValue in
                if !newValue.isEmpty {
                    viewModel.email = ""
                    viewModel.password = ""
                }
            }
            .onChange(of: isOTPValid) { oldValue, newValue in
                if newValue {
                    withAnimation {
                        sessionManager.setLoggedIn(status: true)
                    }
                }
            }
            
            if (sessionManager.isLoggedIn == true) {
                DashboardView()
                    .environmentObject(sessionManager)
            }
        })
    }
}

#Preview {
    LoginView()
        .environmentObject(SessionManager())
}
