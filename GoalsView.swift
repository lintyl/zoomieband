//
//  GoalsView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 12/02/25.
//

import SwiftUI

// MARK: - Goals View

struct GoalsView: View {
    @EnvironmentObject var petProfile: PetProfile

    var body: some View {
        ZStack {
            Color.zoomieBackground
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    breedComparisonSection
                    activeGoalsSection
                    achievementsSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 95)
            }
        }
    }
}

// MARK: - Sections

private extension GoalsView {
    var headerSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Goals &\nAchievements")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Track \(petProfile.name)'s milestones")
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer()
            
            Button {
                // TODO: Add a Goal Action
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                    Text("New Goal")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(Color.zoomieAccent)
                )
                .shadow(color: .zoomieAccent.opacity(0.35), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
    }
    
    var breedComparisonSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Title row
            HStack(spacing: 10) {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.zoomieAccent.opacity(0.12))
                            .frame(width: 32, height: 32)
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.zoomieAccent)
                    }
                    
                    Text("Breed Comparison")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                }
                
                Spacer()
                
                Text("\(petProfile.breed)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.zoomiePrimary)
                    )
            }
            
            // Overall Performance Card
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Overall Performance")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.85))
                        Text("Top 32%")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(petProfile.name) is more active than 68% of \(petProfile.breed)s on ZoomieBand")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.22))
                            .frame(width: 64, height: 64)
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.zoomieAccent,
                                Color.zoomieAccent.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .shadow(color: Color.zoomieAccent.opacity(0.35), radius: 16, x: 0, y: 8)
            
            // Metric Cards
            VStack(spacing: 16) {
                GoalComparisonMetricCard(
                    title: "Daily Steps",
                    deltaText: "+12%",
                    primaryLabel: "\(petProfile.name)'s Average",
                    primaryValue: "8,432 steps",
                    secondaryLabel: "Breed Average",
                    secondaryValue: "7,500 steps",
                    percentileText: "68th percentile",
                    progress: 0.68
                )
                
                GoalComparisonMetricCard(
                    title: "Weekly Distance",
                    deltaText: "+10%",
                    primaryLabel: "\(petProfile.name)'s Average",
                    primaryValue: "38.5 km",
                    secondaryLabel: "Breed Average",
                    secondaryValue: "35 km",
                    percentileText: "72th percentile",
                    progress: 0.72
                )
                
                GoalComparisonMetricCard(
                    title: "Active Minutes",
                    deltaText: "+13%",
                    primaryLabel: "\(petProfile.name)'s Average",
                    primaryValue: "85 min/day",
                    secondaryLabel: "Breed Average",
                    secondaryValue: "75 min/day",
                    percentileText: "65th percentile",
                    progress: 0.65
                )
            }
        }
    }
    
    var activeGoalsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Active Goals")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            VStack(spacing: 16) {
                GoalProgressCard(
                    iconName: "shoeprints.fill",
                    iconBackground: Color.zoomieAccent.opacity(0.14),
                    iconColor: Color.zoomieAccent,
                    title: "Daily Steps",
                    subtitle: "Walk 10,000 steps every day",
                    progress: 0.84,
                    progressText: "8,432 / 10,000 steps",
                    percentText: "84%"
                )
                
                GoalProgressCard(
                    iconName: "target",
                    iconBackground: Color.orange.opacity(0.16),
                    iconColor: Color.orange,
                    title: "Weekly Distance",
                    subtitle: "Cover 50km this week",
                    progress: 0.77,
                    progressText: "38.5 / 50 km",
                    percentText: "77%"
                )
                
                GoalProgressCard(
                    iconName: "flame.fill",
                    iconBackground: Color.red.opacity(0.16),
                    iconColor: Color.red,
                    title: "Calorie Burn",
                    subtitle: "Burn 2,500 calories weekly",
                    progress: 0.86,
                    progressText: "2,140 / 2,500 kcal",
                    percentText: "86%"
                )
            }
        }
    }
    
    var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Achievements")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                
                Spacer()
                
                HStack(spacing: 6) {
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 14, weight: .semibold))
                    Text("3")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.zoomiePrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.white)
                )
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
            }
            
            VStack(spacing: 0) {
                AchievementRow(
                    iconName: "trophy",
                    iconBackground: Color.zoomieAccent.opacity(0.18),
                    iconColor: Color.zoomieAccent,
                    title: "First 10K",
                    subtitle: "Completed first 10,000 steps in a day",
                    dateText: "Jan 2024"
                )
                
                Divider()
                    .padding(.horizontal, 18)
                
                AchievementRow(
                    iconName: "star.fill",
                    iconBackground: Color.orange.opacity(0.18),
                    iconColor: Color.orange,
                    title: "Week Warrior",
                    subtitle: "Achieved all daily goals for 7 days",
                    dateText: "Jan 2024"
                )
                
                Divider()
                    .padding(.horizontal, 18)
                
                AchievementRow(
                    iconName: "rosette",
                    iconBackground: Color.green.opacity(0.18),
                    iconColor: Color.green,
                    title: "Distance Master",
                    subtitle: "Covered 100km in a month",
                    dateText: "Dec 2023"
                )
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(Color.white)
            )
            .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
        }
    }
}

// MARK: - Reusable Views

struct GoalComparisonMetricCard: View {
    let title: String
    let deltaText: String
    let primaryLabel: String
    let primaryValue: String
    let secondaryLabel: String
    let secondaryValue: String
    let percentileText: String
    let progress: CGFloat  // 0.0 – 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                
                Spacer()
                
                Text(deltaText)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.zoomieAccent)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(primaryLabel)
                        .font(.system(size: 13))
                        .foregroundColor(.zoomieSecondaryText)
                    
                    Spacer()
                    
                    Text(primaryValue)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.zoomiePrimary)
                }
                
                HStack {
                    Text(secondaryLabel)
                        .font(.system(size: 13))
                        .foregroundColor(.zoomieSecondaryText)
                    
                    Spacer()
                    
                    Text(secondaryValue)
                        .font(.system(size: 15))
                        .foregroundColor(.zoomieSecondaryText)
                }
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.zoomieProgressBackground)
                    Capsule()
                        .fill(Color.zoomieAccent)
                        .frame(width: geo.size.width * max(0, min(progress, 1)))
                }
            }
            .frame(height: 8)
            
            Text(percentileText)
                .font(.system(size: 13))
                .foregroundColor(.zoomieSecondaryText)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
    }
}

struct GoalProgressCard: View {
    let iconName: String
    let iconBackground: Color
    let iconColor: Color
    let title: String
    let subtitle: String
    let progress: CGFloat  // 0.0 – 1.0
    let progressText: String
    let percentText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(iconBackground)
                        .frame(width: 44, height: 44)
                    Image(systemName: iconName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.zoomieSecondaryText)
                }
                
                Spacer()
                
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.zoomieProgressBackground)
                    Capsule()
                        .fill(Color.zoomieAccent)
                        .frame(width: geo.size.width * max(0, min(progress, 1)))
                }
            }
            .frame(height: 8)
            
            HStack {
                Text(progressText)
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
                
                Spacer()
                
                Text(percentText)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.zoomieAccent)
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
    }
}

struct AchievementRow: View {
    let iconName: String
    let iconBackground: Color
    let iconColor: Color
    let title: String
    let subtitle: String
    let dateText: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(iconBackground)
                    .frame(width: 48, height: 48)
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
                
                Text(dateText)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.zoomieSecondaryText.opacity(0.9))
                    .padding(.top, 2)
            }
            
            Spacer()
            
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
            .environmentObject(PetProfile())
    }
}
