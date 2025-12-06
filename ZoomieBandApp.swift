//
//  ZoomieBandApp.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 11/28/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ZoomieBandApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var petProfile = PetProfile()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
                    .environmentObject(PetProfile())
            } else {
                LoginView()
            }
        }
    }
}
