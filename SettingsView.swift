//
//  SettingsView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 12/01/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SettingsView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @EnvironmentObject var petProfile: PetProfile
    
    @State private var sheetIsPresented = false
    @State private var tempName: String = ""
    @State private var tempBreed: String = ""
    @State private var tempBirthday: Date = Date()
    
    var body: some View {
        ZStack {
            Color.zoomieBackground
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    
                    accountSection
                    preferencesSection
                    supportSection
                    logoutButton
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 100)
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            EditProfileSheet(
                name: $tempName,
                breed: $tempBreed,
                birthday: $tempBirthday,
                onSave: {
                    petProfile.name = tempName
                    petProfile.breed = tempBreed
                    petProfile.birthday = tempBirthday
                }
            )
            .presentationDetents([.fraction(0.95)])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Sections

private extension SettingsView {
    var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Settings")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            Text("Manage your preferences")
                .font(.system(size: 14))
                .foregroundColor(.zoomieSecondaryText)
        }
    }
    
    var accountSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Account")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            VStack(spacing: 0) {
                // Profile Information Row
                Button {
                    tempName = petProfile.name
                    tempBreed = petProfile.breed
                    tempBirthday = petProfile.birthday
                    sheetIsPresented = true
                } label: {
                    settingsRow(
                        iconName: "person.crop.circle",
                        iconColor: .zoomieAccent,
                        title: "Profile Information",
                        subtitle: "Update your details"
                    )
                }
                .buttonStyle(.plain)
                
                Divider().padding(.leading, 68)
                
                // Connected Devices Row (Dummy)
                Button {
                    // TODO: Action Here
                } label: {
                    settingsRow(
                        iconName: "rectangle.connected.to.line.below",
                        iconColor: .orange,
                        title: "Connected Devices",
                        subtitle: "Manage fitness trackers"
                    )
                }
                .buttonStyle(.plain)
            }
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
        }
    }
    
    var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preferences")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            VStack(spacing: 0) {
                // Notifications Row
                settingsToggleRow(
                    iconName: "bell.badge",
                    iconColor: .zoomieAccent,
                    title: "Notifications",
                    subtitle: "Activity reminders",
                    isOn: .constant(true)
                )
                
                Divider().padding(.leading, 68)
                
                // Dark Mode Row (TODO: Add Toggle)
                settingsToggleRow(
                    iconName: "moon.fill",
                    iconColor: .gray,
                    title: "Dark Mode",
                    subtitle: "Switch appearance",
                    isOn: .constant(false)
                )
                
                Divider().padding(.leading, 68)
                
                // Data & Storage Row
                Button {
                    // TODO: Action Here
                } label: {
                    settingsRow(
                        iconName: "externaldrive",
                        iconColor: .green,
                        title: "Data & Storage",
                        subtitle: "Manage app data"
                    )
                }
                .buttonStyle(.plain)
            }
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
        }
    }
    
    var supportSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Support & About")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            VStack(spacing: 0) {
                Button {
                    // TODO: Action Here
                } label: {
                    settingsRow(
                        iconName: "questionmark.circle",
                        iconColor: .zoomieAccent,
                        title: "Help Center",
                        subtitle: "Get support"
                    )
                }
                .buttonStyle(.plain)
                
                Divider().padding(.leading, 68)
                
                Button {
                    // TODO: Action Here
                } label: {
                    settingsRow(
                        iconName: "doc.text",
                        iconColor: .orange,
                        title: "Privacy Policy",
                        subtitle: "Read our terms"
                    )
                }
                .buttonStyle(.plain)
                
                Divider().padding(.leading, 68)
                
                Button {
                    // TODO: Action Here
                } label: {
                    settingsRow(
                        iconName: "shield.checkerboard",
                        iconColor: .green,
                        title: "About ZoomieBand",
                        subtitle: "Version 1.0.0"
                    )
                }
                .buttonStyle(.plain)
            }
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
        }
    }
    
    var logoutButton: some View {
        Button {
            signout()
        } label: {
            Text("Log Out")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(Color.red)
                )
        }
        .buttonStyle(.plain)
        .padding(.top, 4)
    }
    
    // MARK: - Functions
    
    func signout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            print("Successfully signed out!")
        } catch {
            print("SIGNOUT ERROR: \(error.localizedDescription)")
        }
    }

    func settingsRow(iconName: String,
                     iconColor: Color,
                     title: String,
                     subtitle: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.zoomiePrimary)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.zoomieSecondaryText.opacity(0.7))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
    }
    
    func settingsToggleRow(iconName: String,
                           iconColor: Color,
                           title: String,
                           subtitle: String,
                           isOn: Binding<Bool>) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.zoomiePrimary)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer()
            
            Toggle("", isOn: isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
    }
}

// MARK: - Edit Profile Sheet

struct EditProfileSheet: View {
    @Binding var name: String
    @Binding var breed: String
    @Binding var birthday: Date
    var onSave: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: Field?
    enum Field {
        case name, breed
    }
    
    private var ageText: String {
        let now = Date()
        guard birthday <= now else { return "0.0 years" }
        let days = Calendar.current.dateComponents([.day], from: birthday, to: now).day ?? 0
        let years = Double(days) / 365.25
        let rounded = (years * 10).rounded() / 10
        return String(format: "%.1f years", rounded)
    }
    
    var body: some View {
        ZStack {
            Color.zoomieBackground.opacity(0.96)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                HStack {
                    
                    Spacer()
                    
                    Text("Edit Profile Information")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.zoomieSecondaryText)
                    }
                    .buttonStyle(.plain)
                }
                
                // Profile Photo
                Button {
                    print("Open photo picker later")
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        // Circle Placeholder Avatar
                        Circle()
                            .fill(Color.zoomieProgressBackground.opacity(0.3))
                            .frame(width: 110, height: 110)
                            .overlay(
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.zoomieSecondaryText.opacity(0.5))
                                    .frame(width: 70, height: 70)
                            )
                        
                        // "+" Badge
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 34, height: 34)
                                .shadow(radius: 2)

                            Circle()
                                .fill(Color.zoomieAccent)
                                .frame(width: 28, height: 28)

                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                        .offset(x: 4, y: 4)
                    }
                }
                .buttonStyle(.plain)
                .padding(.bottom, 8)

                
                VStack(alignment: .leading, spacing: 18) {
                    // Name
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Pet Name")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                        
                        TextField("Pet name", text: $name)
                            .textInputAutocapitalization(.none)
                            .autocorrectionDisabled(true)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        focusedField == .name ? Color.zoomieAccent : Color.zoomieProgressBackground,
                                        lineWidth: focusedField == .name ? 2 : 1
                                    )
                            )
                            .focused($focusedField, equals: .name)
                    }
                    
                    // Breed
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Breed")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                        
                        TextField("Breed", text: $breed)
                            .textInputAutocapitalization(.none)
                            .autocorrectionDisabled(true)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        focusedField == .breed ? Color.zoomieAccent : Color.zoomieProgressBackground,
                                        lineWidth: focusedField == .breed ? 2 : 1
                                    )
                            )
                            .focused($focusedField, equals: .breed)
                    }
                    
                    // Birthday + Age
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Birthday")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                        
                        DatePicker(
                            "Birthday",
                            selection: $birthday,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(Color.zoomieProgressBackground, lineWidth: 1)
                        )
                        
                        Text("Age: \(ageText)")
                            .font(.system(size: 12))
                            .foregroundColor(.zoomieSecondaryText)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .stroke(Color.zoomieProgressBackground, lineWidth: 1.5)
                            )
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        onSave()
                        dismiss()
                    } label: {
                        Text("Save Changes")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .fill(Color.zoomieAccent)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 55)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(PetProfile())
    }
}
