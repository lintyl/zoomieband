//
//  HistoryView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 11/28/25.
//

import SwiftUI

// MARK: - Models

struct DayActivity: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let steps: Int
    let distanceKm: Double
    let timeHours: Double
    let calories: Int
    let trendUp: Bool
}

enum HistoryRange: String, CaseIterable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
}

// MARK: - History View

struct HistoryView: View {
    @State private var selectedRange: HistoryRange = .week
    @EnvironmentObject var petProfile: PetProfile
    
    // TODO: Sample week data
    private let weekActivities: [DayActivity] = [
        DayActivity(title: "Today",
                    subtitle: "Daily Activity",
                    steps: 8432,
                    distanceKm: 6.2,
                    timeHours: 2.5,
                    calories: 342,
                    trendUp: true),
        DayActivity(title: "Yesterday",
                    subtitle: "Daily Activity",
                    steps: 9200,
                    distanceKm: 6.8,
                    timeHours: 2.8,
                    calories: 374,
                    trendUp: true),
        DayActivity(title: "Sun, Nov 30",
                    subtitle: "Daily Activity",
                    steps: 7800,
                    distanceKm: 5.9,
                    timeHours: 2.1,
                    calories: 310,
                    trendUp: false),
        DayActivity(title: "Sat, Nov 29",
                    subtitle: "Daily Activity",
                    steps: 6900,
                    distanceKm: 5.0,
                    timeHours: 1.9,
                    calories: 295,
                    trendUp: false),
        DayActivity(title: "Fri, Nov 28",
                    subtitle: "Daily Activity",
                    steps: 10200,
                    distanceKm: 7.4,
                    timeHours: 3.0,
                    calories: 398,
                    trendUp: true)
    ]
    
    var body: some View {
        ZStack {
            Color.zoomieBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                header
                
                rangePicker
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        if selectedRange == .week {
                            ForEach(weekActivities) { activity in
                                ActivityDayCard(activity: activity)
                            }
                        } else {
                            // Placeholder Data
                            VStack(spacing: 8) {
                                Text("No \(selectedRange.rawValue.lowercased()) data yet")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.zoomiePrimary)
                                Text("Track more walks with \(petProfile.name) to see history here.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.zoomieSecondaryText)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 40)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 70)
        }
    }
}

// MARK: - Subviews

private extension HistoryView {
    var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Activity History")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            Text("\(petProfile.name)'s past activities")
                .font(.system(size: 14))
                .foregroundColor(.zoomieSecondaryText)
        }
    }
    
    var rangePicker: some View {
        HStack(spacing: 0) {
            ForEach(HistoryRange.allCases, id: \.self) { range in
                Button {
                    selectedRange = range
                } label: {
                    Text(range.rawValue)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(
                            range == selectedRange
                            ? .zoomiePrimary
                            : .zoomieSecondaryText
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(range == selectedRange ? Color.white : Color.clear)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.white.opacity(0.7))
        )
        .shadow(color: .black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

// Card for Each Day
struct ActivityDayCard: View {
    let activity: DayActivity
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(activity.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    Text(activity.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.zoomieSecondaryText)
                }
                
                // 2x2 Stat Grid
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 24) {
                        statBlock(
                            icon: "shoeprints.fill",
                            iconColor: .zoomieAccent,
                            title: "Steps",
                            value: "\(activity.steps.formatted(.number.grouping(.automatic)))"
                        )
                        
                        statBlock(
                            icon: "waveform.path.ecg",
                            iconColor: .orange,
                            title: "Distance",
                            value: String(format: "%.1f km", activity.distanceKm)
                        )
                    }
                    
                    HStack(spacing: 24) {
                        statBlock(
                            icon: "clock",
                            iconColor: .green,
                            title: "Time",
                            value: String(format: "%.1f hrs", activity.timeHours)
                        )
                        
                        statBlock(
                            icon: "flame.fill",
                            iconColor: .red,
                            title: "Calories",
                            value: "\(activity.calories)"
                        )
                    }
                }
            }
            
            Spacer()
            
            // Trend Icon
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.green.opacity(0.12))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: activity.trendUp ? "chart.line.uptrend.xyaxis" : "chart.line.downtrend.xyaxis")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.green)
                )
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 18, x: 0, y: 8)
    }
    
    private func statBlock(icon: String, iconColor: Color, title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(iconColor)
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Text(value)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.zoomiePrimary)
        }
    }
}

// MARK: - Preview

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(PetProfile())
    }
}
