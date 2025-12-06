//
//  LoginView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 12/4/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonDisabled = true
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email
        case password
    }
    
    var body: some View {
        VStack(spacing: 28) {
            
            // App Logo
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(.top, 90)
            
            // MARK: - Input Fields
            VStack(spacing: 18) {
                
                // EMAIL
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(
                                focusedField == .email ? Color.zoomieAccent : Color.zoomieProgressBackground,
                                lineWidth: focusedField == .email ? 2 : 1
                            )
                    )
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }
                    .onChange(of: email) {
                        enableButtons()
                    }
                
                // PASSWORD
                SecureField("Password", text: $password)
                    .autocorrectionDisabled()
                    .submitLabel(.done)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(
                                focusedField == .password ? Color.zoomieAccent : Color.zoomieProgressBackground,
                                lineWidth: focusedField == .password ? 2 : 1
                            )
                    )
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = nil // Nil will dismiss the keyboard
                    }
                    .onChange(of: password) {
                        enableButtons()
                    }
            }
            .padding(.horizontal, 20)
            
            // MARK: - Buttons
            VStack(spacing: 16) {
                HStack(spacing: 20) {
                    Button("Sign Up") {
                        register()
                    }
                    
                    Button("Log In") {
                        login()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.zoomieAccent)
                .font(.title3.bold())
                .disabled(buttonDisabled)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    
    // MARK: - Button Behaviour
    func enableButtons() {
        let emailIsGood = email.count > 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    // MARK: - Auth
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result,
            error in
            if let error = error {
                print("SIGNUP ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration Success!")
                alertMessage = "Registration successful! Please log in."
                showingAlert = true
                focusedField = .password
                password = ""
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Log In Success!")
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    LoginView()
}
