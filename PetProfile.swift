//
//  PetProfile.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 12/2/25.
//

import Foundation
import SwiftUI
import Combine

final class PetProfile: ObservableObject {
    @Published var name: String
    @Published var breed: String
    @Published var birthday: Date
    
    var ageYears: Double {
        let now = Date()
        guard birthday <= now else { return 0.0 }
        
        let days = Calendar.current.dateComponents([.day], from: birthday, to: now).day ?? 0
        let years = Double(days) / 365.25
        return (years * 10).rounded() / 10
    }
    
    init (
        name: String = "Max",
        breed: String = "Golden Retriever",
        birthday: Date = {
            var components = DateComponents()
            components.year = 2017
            components.month = 7
            components.day = 29
            components.hour = 12
            components.minute = 0
            components.second = 0
            return Calendar.current.date(from: components) ?? Date()
        }()
    ) {
        self.name = name
        self.breed = breed
        self.birthday = birthday
    }
}
