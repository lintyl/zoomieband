//
//  HomeView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 11/28/25.
//

import SwiftUI

// MARK: - Main Home Screen

struct HomeView: View {
    @State private var selectedTab: ZoomieTab = .home
    @EnvironmentObject var petProfile: PetProfile
    
    var body: some View {
        ZStack {
            Color.zoomieBackground
                .ignoresSafeArea()
            
            Group {
                if selectedTab == .home {
                    VStack(spacing: 0) {
                        header
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                statsGrid
                                dailyGoalCard
                                playPlanCard
                                weeklyActivityCard
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 90)
                        }
                    }
                } else if selectedTab == .history {
                    HistoryView()
                } else if selectedTab == .goals {
                    GoalsView()
                } else if selectedTab == .community {
                    CommunityView()
                } else if selectedTab == .settings {
                    SettingsView()
                } else {
                    VStack {
                        Text("\(selectedTab.title) coming soon")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.zoomieSecondaryText)
                            .padding(.top, 40)
                        
                        Spacer()
                        
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            zoomieTabBar(selectedTab: $selectedTab)
                .padding(.bottom, 8)
                .background(Color.white)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Header

private extension HomeView {
    var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("ZoomieBand")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                Text("Track \(petProfile.name)’s fitness journey")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                    .overlay(
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.zoomiePrimary)
                    )
                    .overlay(
                        Circle()
                            .fill(Color.zoomieAccent)
                            .frame(width: 12, height: 12)
                            .offset(x: 3, y: 0),
                        alignment: .topTrailing
                    )
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                    .overlay(
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 4)
    }
}

// MARK: - Stats Grid

private extension HomeView {
    var statsGrid: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                StatCardView(
                    iconName: "figure.walk",
                    iconBackground: .zoomieAccent.opacity(0.19),
                    iconForeground: .zoomieAccent,
                    title: "Steps",
                    value: "8,432",
                    unit: "steps"
                )
                
                StatCardView(
                    iconName: "location",
                    iconBackground: .orange.opacity(0.16),
                    iconForeground: .orange,
                    title: "Distance",
                    value: "6.2",
                    unit: "km"
                )
            }
            
            HStack(spacing: 16) {
                StatCardView(
                    iconName: "clock",
                    iconBackground: .green.opacity(0.16),
                    iconForeground: .green,
                    title: "Active Time",
                    value: "2.5",
                    unit: "hrs"
                )
                
                StatCardView(
                    iconName: "flame.fill",
                    iconBackground: .red.opacity(0.14),
                    iconForeground: .red,
                    title: "Calories",
                    value: "342",
                    unit: "kcal"
                )
            }
        }
    }
}

// MARK: - Daily Goal Card

private extension HomeView {
    var dailyGoalCard: some View {
        DailyGoalCardView(
            title: "Daily Goal",
            subtitle: "10,000 steps",
            progress: 0.84,
            leftLabel: "84% complete",
            rightLabel: "1,568 to go"
        )
    }
}

// MARK: - Play Plan Card

private extension HomeView {
    var playPlanCard: some View {
        PlayPlanCardView(
            title: "Today’s Play Plan"
        )
    }
}

// MARK: - Weekly Activity Card

private extension HomeView {
    var weeklyActivityCard: some View {
        WeeklyActivityCardView()
    }
}

// MARK: - App Build Components

struct StatCardView: View {
    let iconName: String
    let iconBackground: Color
    let iconForeground: Color
    let title: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(iconBackground)
                    .frame(width: 46, height: 46)
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(iconForeground)
            }
            
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.zoomieSecondaryText)
                .lineLimit(1)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                
                Text(unit)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer(minLength: 0)
            
        }
        .padding(20)
        .frame(maxWidth: .infinity,
               minHeight: 150,
               maxHeight: 150,
               alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 6)
    }
}

struct DailyGoalCardView: View {
    let title: String
    let subtitle: String
    let progress: CGFloat // 0.0 – 1.0
    let leftLabel: String
    let rightLabel: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color.zoomieAccent.opacity(0.16))
                        .frame(width: 40, height: 40)
                    Image(systemName: "target")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.zoomieAccent)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    Text(subtitle)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.zoomieSecondaryText)
                }
                
                Spacer()
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.zoomieProgressBackground)
                        
                        Capsule()
                            .fill(Color.zoomieAccent)
                            .frame(width: geo.size.width * max(0, min(progress, 1)))
                    }
                }
                .frame(height: 10)
                
                HStack {
                    Text(leftLabel)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.zoomieSecondaryText)
                    
                    Spacer()
                    
                    Text(rightLabel)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.zoomieAccent)
                }
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

// MARK: - Checklist / Play Plan

struct PlayPlanCardView: View {
    let title: String
    
    struct Task: Identifiable {
        let id = UUID()
        let label: String
        var isCompleted: Bool = false
    }
    
    @State private var tasks: [Task] = [
        Task(label: "Sit"),
        Task(label: "Stay"),
        Task(label: "Down"),
        Task(label: "Come"),
        Task(label: "Heel"),
        Task(label: "Leave It")
    ]
    
    private var completedCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    private var progress: CGFloat {
        guard !tasks.isEmpty else { return 0 }
        return CGFloat(completedCount) / CGFloat(tasks.count)
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 10) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.zoomieAccent.opacity(0.16))
                            .frame(width: 32, height: 32)
                        Image(systemName: "calendar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.zoomieAccent)
                    }
                    
                    Text(title)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                }
                
                Spacer()
                
                Text("\(completedCount)/\(tasks.count)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.zoomieProgressBackground)
                    Capsule()
                        .fill(Color.zoomieAccent)
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 6)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                ForEach(Array(tasks.indices), id: \.self) { index in
                    let task = tasks[index]
                    PlayTaskPill(
                        label: task.label,
                        isCompleted: task.isCompleted
                    ) {
                        tasks[index].isCompleted.toggle()
                    }
                }
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

struct PlayTaskPill: View {
    let label: String
    let isCompleted: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(Color.zoomieAccent, lineWidth: 2)
                    .frame(width: 20, height: 20)
                
                if isCompleted {
                    Circle()
                        .fill(Color.zoomieAccent)
                        .frame(width: 12, height: 12)
                }
            }
            
            Text(label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.zoomiePrimary)
            
            Spacer()
            
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.zoomieAccent.opacity(isCompleted ? 0.15 : 0.05))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.zoomieAccent.opacity(0.4), lineWidth: 1)
        )
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Weekly Activity Card

struct WeeklyActivityCardView: View {
    private let values: [CGFloat] = [0.8, 0.65, 0.75, 1.0, 0.6]
    private let barSpacing: CGFloat = 14
    private var labels: [String] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        
        return (0..<values.count).map { index in
            let offset = index - (values.count - 1)   // -4, -3, -2, -1, 0
            let date = calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()
            return formatter.string(from: date)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Weekly Activity")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            
            HStack(alignment: .bottom, spacing: 16) {
                // Y-axis labels
                VStack(alignment: .leading, spacing: 12) {
                    Text("15k")
                    Text("12.5k")
                    Text("10k")
                    Text("7.5k")
                    Text("5k")
                    Text("2.5k")
                    Text("0k")
                }
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.zoomieSecondaryText)
                
                // Bars + X-axis labels
                VStack(spacing: 8) {
                    GeometryReader { geo in
                        HStack(alignment: .bottom, spacing: barSpacing) {
                            ForEach(values.indices, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(index == values.count - 1
                                          ? Color.zoomieAccent         // today highlighted
                                          : Color.zoomieProgressBackground)
                                    .frame(
                                        width: (geo.size.width
                                                - barSpacing * CGFloat(values.count - 1))
                                        / CGFloat(values.count),
                                        height: geo.size.height * values[index]
                                    )
                            }
                        }
                    }
                    .frame(height: 120)
                    
                    HStack(spacing: barSpacing) {
                        ForEach(labels.indices, id: \.self) { index in
                            Text(labels[index])
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.zoomieSecondaryText)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                    }
                    .padding(.top, 6)
                }
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


// MARK: - Tab Bar

enum ZoomieTab: String, CaseIterable {
    case home
    case history
    case goals
    case community
    case settings
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .history: return "History"
        case .goals: return "Goals"
        case .community: return "Community"
        case .settings: return "Settings"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .history: return "clock.arrow.circlepath"
        case .goals: return "target"
        case .community: return "person.3.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

struct zoomieTabBar: View {
    @Binding var selectedTab: ZoomieTab
    
    var body: some View {
        HStack {
            ForEach(ZoomieTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 18, weight: .semibold))
                        Text(tab.title)
                            .font(.system(size: 11, weight: .semibold))
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(
                        tab == selectedTab ? Color.zoomieAccent : Color.zoomieSecondaryText
                    )
                    .background(
                        Group {
                            if tab == .home {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.zoomieAccent.opacity(tab == selectedTab ? 0.16 : 0))
                            } else {
                                Color.clear
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            Color.white
                .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: -4)
        )
    }
}

// MARK: - Colors

extension Color {
    static let zoomieBackground = Color(red: 244/255, green: 248/255, blue: 255/255)
    static let zoomiePrimary = Color(red: 18/255, green: 27/255, blue: 52/255)
    static let zoomieSecondaryText = Color(red: 132/255, green: 142/255, blue: 160/255)
    static let zoomieAccent = Color(red: 0/255, green: 204/255, blue: 196/255)
    static let zoomieProgressBackground = Color(red: 224/255, green: 234/255, blue: 248/255)
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PetProfile())
    }
}
