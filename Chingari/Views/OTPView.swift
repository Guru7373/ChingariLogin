//
//  OTPView.swift
//  Chingari
//
//  Created by Guru on 05/05/24.
//

import SwiftUI

struct OTPView: View {
    
    @Binding var isPresented: Bool
    @Binding var phoneNumber: String
    @Binding var isValid: Bool
    @State private var enteredOTP: String = ""
    @State private var showInvalidAlert = false

    var body: some View {
        VStack {
            Text("Verify Mobile Number")
                .font(.headline)
                .padding(.bottom, 30)
            
            HStack(spacing: 30) {
                Text("Enter the OTP sent to your mobile number \(phoneNumber)")
                    .font(.body)
                    .foregroundStyle(Color(.gray))
                
                Button(action: {
                    isPresented = false
                    isValid = false
                }) {
                    Text("Edit")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                .padding(.top)
            }
            
            TextField("OTP", text: $enteredOTP)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                .padding(.top, 20)
            
            Button(action: {
                if (enteredOTP == "111111") {
                    isValid = true
                    isPresented = false
                } else {
                    showInvalidAlert = true
                }
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top, 30)
            .alert(isPresented: $showInvalidAlert, content: {
                Alert(title: Text("Invalid OTP"), message: Text("Entered OTP is invalid"), dismissButton: .default(Text("OK")))
            })
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    OTPView(isPresented: .constant(true),
            phoneNumber: .constant("1234567890"),
            isValid: .constant(false))
}
