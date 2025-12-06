//
//  CommunityView.swift
//  ZoomieBand
//
//  Created by Tyler Lin on 11/28/25.
//

import SwiftUI

// MARK: - Models

struct CommunityPost: Identifiable {
    @EnvironmentObject var petProfile: PetProfile
    
    let id = UUID()
    let petName: String
    let activityTitle: String
    let timeAgo: String
    let distance: String
    let duration: String
    let pace: String
    let location: String
    var kudos: Int
    let comments: Int
    var isLiked: Bool = false
    let imageName: String?
    
    init(
        petName: String,
        activityTitle: String,
        timeAgo: String,
        distance: String,
        duration: String,
        pace: String,
        location: String,
        kudos: Int,
        comments: Int,
        isLiked: Bool = false,
        imageName: String? = nil
    ) {
        self.petName = petName
        self.activityTitle = activityTitle
        self.timeAgo = timeAgo
        self.distance = distance
        self.duration = duration
        self.pace = pace
        self.location = location
        self.kudos = kudos
        self.comments = comments
        self.isLiked = isLiked
        self.imageName = imageName
    }
}

enum CommunityTab: String, CaseIterable {
    case feed = "Feed"
    case challenges = "Challenges"
    case leaderboard = "Leaderboard"
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let distance: String
    let trophy: Trophy?
    let imageName: String?
    
    enum Trophy {
        case gold, silver, bronze
    }
    
    init(
        rank: Int,
        name: String,
        distance: String,
        trophy: Trophy?,
        imageName: String? = nil
    ) {
        self.rank = rank
        self.name = name
        self.distance = distance
        self.trophy = trophy
        self.imageName = imageName
    }
}

struct CommunityChallenge: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let daysRemaining: Int
    let current: Double
    let total: Double
    let unit: String
    let participants: Int
}

// MARK: - Community View

struct CommunityView: View {
    @State private var selectedTab: CommunityTab = .feed
    @State private var posts: [CommunityPost] = [
        CommunityPost(
            petName: "Willi",
            activityTitle: "Morning Walk",
            timeAgo: "2 hours ago",
            distance: "2.4 mi",
            duration: "45min",
            pace: "18:45/mi",
            location: "Memorial Park",
            kudos: 12,
            comments: 3,
            isLiked: false,
            imageName: "willi"
        ),
        CommunityPost(
            petName: "Alex",
            activityTitle: "Evening Walk",
            timeAgo: "10 hours ago",
            distance: "0.3 mi",
            duration: "15min",
            pace: "50:00/mi",
            location: "Charles River Esplanade",
            kudos: 24,
            comments: 7,
            isLiked: false,
            imageName: "alex"
        ),
        CommunityPost(
            petName: "Mylo",
            activityTitle: "Beach Walk",
            timeAgo: "1 day ago",
            distance: "1.8 mi",
            duration: "32min",
            pace: "17:47/mi",
            location: "Huntington Dog Beach",
            kudos: 18,
            comments: 5,
            imageName: "mylo"
        ),
        CommunityPost(
            petName: "Bodhi",
            activityTitle: "Morning Walk",
            timeAgo: "1 day ago",
            distance: "0.3 mi",
            duration: "15min",
            pace: "50:00/mi",
            location: "Huntington Dog Beach",
            kudos: 18,
            comments: 5,
            imageName: "bodhi"
        )
    ]
    
    private let leaderboardEntries: [LeaderboardEntry] = [
        LeaderboardEntry(
            rank: 1,
            name: "Kora",
            distance: "87.4 mi",
            trophy: .gold,
            imageName: "kora"
        ),
        LeaderboardEntry(
            rank: 2,
            name: "Willi",
            distance: "82.1 mi",
            trophy: .silver,
            imageName: "willi"
        ),
        LeaderboardEntry(
            rank: 3,
            name: "Bodhi",
            distance: "76.8 mi",
            trophy: .bronze,
            imageName: "bodhi"
        ),
        LeaderboardEntry(
            rank: 4,
            name: "Mylo",
            distance: "71.3 mi",
            trophy: nil,
            imageName: "mylo"
        ),
        LeaderboardEntry(
            rank: 5,
            name: "Yogi",
            distance: "68.9 mi",
            trophy: nil,
            imageName: "yogi"
        )
    ]
    
    private let challenges: [CommunityChallenge] = [
        CommunityChallenge(
            title: "December Walking Challenge",
            subtitle: "Walk 50 miles this month",
            daysRemaining: 29,
            current: 2.0,
            total: 50,
            unit: "mi",
            participants: 234
        ),
        CommunityChallenge(
            title: "Weekday Warrior",
            subtitle: "Complete 5 walks this week",
            daysRemaining: 3,
            current: 2,
            total: 5,
            unit: "mi",
            participants: 72
        )
    ]
    
    var body: some View {
        ZStack {
            Color.zoomieBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                header
                tabPicker
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        switch selectedTab {
                        case .feed:
                            ForEach(posts.indices, id: \.self) { index in
                                CommunityPostCard(
                                    post: posts[index],
                                    onKudos: {
                                        posts[index].isLiked.toggle()
                                        
                                        if posts[index].isLiked {
                                            posts[index].kudos += 1
                                        } else {
                                            posts[index].kudos = max(0, posts[index].kudos - 1)
                                        }
                                    }
                                )
                            }
                            
                        case .challenges:
                            VStack(spacing: 16) {
                                ForEach(challenges) { challenge in
                                    ChallengeCard(challenge: challenge)
                                }
                            }
                            .padding(.top, 4)
                            
                        case .leaderboard:
                            LeaderboardCard(entries: leaderboardEntries)
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

// MARK: - Header & Tabs

private extension CommunityView {
    var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Community")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.zoomiePrimary)
                Text("Connect with other pet parents")
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
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.zoomiePrimary)
                    )
            }
        }
//        .padding(.horizontal, 20)
//        .padding(.top, 12)
//        .padding(.bottom, 4)
    }

//    var header: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text("Community")
//                .font(.system(size: 28, weight: .bold))
//                .foregroundColor(.zoomiePrimary)
//            
//            Text("Connect with other pet parents")
//                .font(.system(size: 14))
//                .foregroundColor(.zoomieSecondaryText)
//        }
//    }
        
    
    var tabPicker: some View {
        HStack(spacing: 0) {
            ForEach(CommunityTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    Text(tab.rawValue)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(
                            tab == selectedTab ? .zoomiePrimary : .zoomieSecondaryText
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(tab == selectedTab ? Color.white : Color.clear)
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

// MARK: - Post Card

struct CommunityPostCard: View {
    let post: CommunityPost
    let onKudos: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.zoomieProgressBackground)
                    
                    if let imageName = post.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.zoomieSecondaryText.opacity(0.7))
                    }
                }
                .frame(width: 46, height: 46)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.petName)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    
                    HStack(spacing: 4) {
                        Text(post.activityTitle)
                        Text("•")
                        Text(post.timeAgo)
                    }
                    .font(.system(size: 13))
                    .foregroundColor(.zoomieSecondaryText)
                }
                
                Spacer()
                
            }
            
            // Stats Card
            HStack {
                statBlock(value: post.distance, label: "Distance")
                
                Spacer()
                
                statBlock(value: post.duration, label: "Time")
                
                Spacer()
                
                statBlock(value: post.pace, label: "Pace")
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.zoomieProgressBackground.opacity(0.5))
            )
            
            // Location Row
            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.zoomieSecondaryText)
                Text(post.location)
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Divider()
            
            // Footer row: Kudos / Comments / Share
            HStack {
                KudosButton(count: post.kudos, isLiked: post.isLiked, onTap: onKudos)
                
                Spacer()
                
                HStack(spacing: 6) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 15, weight: .semibold))
                    Text("\(post.comments)")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.zoomieSecondaryText)
                
                Button {
                    // Placeholder Button
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.zoomieSecondaryText)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
    }
    
    private func statBlock(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.zoomiePrimary)
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.zoomieSecondaryText)
        }
    }
}

// MARK: - Challenge Card

struct ChallengeCard: View {
    let challenge: CommunityChallenge
    
    private var progressFraction: CGFloat {
        guard challenge.total > 0 else { return 0 }
        return CGFloat(challenge.current / challenge.total)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title Row
            HStack(alignment: .top) {
                HStack(spacing: 8) {
                    Image(systemName: "trophy.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.zoomieAccent)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(challenge.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.zoomiePrimary)
                        Text(challenge.subtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.zoomieSecondaryText)
                    }
                }
                
                Spacer()
                
                Text("\(challenge.daysRemaining) days")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.zoomiePrimary)
                    )
            }
            
            // Progress Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Progress")
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
                
                HStack {
                    
                    Spacer()
                    
                    Text(
                        "\(String(format: "%.1f", challenge.current)) / \(String(format: "%.0f", challenge.total)) \(challenge.unit)"
                    )
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.zoomiePrimary)
                }
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 999, style: .continuous)
                            .fill(Color.zoomieProgressBackground.opacity(0.3))
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 999, style: .continuous)
                            .fill(Color.zoomieAccent)
                            .frame(width: geo.size.width * progressFraction, height: 8)
                    }
                }
                .frame(height: 8)
            }
            
            // Footer row
            HStack {
                Text("\(challenge.participants) participants")
                    .font(.system(size: 14))
                    .foregroundColor(.zoomieSecondaryText)
                
                Spacer()
                
                Button {
                    // TODO: Action Here
                } label: {
                    Text("Join Challenge")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule(style: .continuous)
                                .fill(Color.zoomieAccent)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
    }
}

// MARK: - Leaderboard Card

struct LeaderboardCard: View {
    let entries: [LeaderboardEntry]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.zoomieAccent)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Monthly Leaders")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.zoomiePrimary)
                    Text("Top walkers this month")
                        .font(.system(size: 13))
                        .foregroundColor(.zoomieSecondaryText)
                }
                
                Spacer()
                
            }
            
            VStack(spacing: 16) {
                ForEach(entries) { entry in
                    LeaderboardRow(entry: entry)
                }
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
    }
}

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    
    private var rankColor: Color {
        switch entry.rank {
        case 1, 2, 3:
            return .zoomieAccent
        default:
            return .zoomieSecondaryText
        }
    }
    
    private var trophyColor: Color {
        switch entry.trophy {
        case .gold:
            return .leaderboardGold
        case .silver:
            return .leaderboardSilver
        case .bronze:
            return .leaderboardBronze
        case .none:
            return .clear
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Text("#\(entry.rank)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(rankColor)
                .frame(width: 36, alignment: .leading)
            
            ZStack {
                Circle()
                    .fill(Color.zoomieProgressBackground)
                
                if let imageName = entry.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } else {
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.zoomieSecondaryText.opacity(0.7))
                }
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.zoomiePrimary)
                Text(entry.distance)
                    .font(.system(size: 13))
                    .foregroundColor(.zoomieSecondaryText)
            }
            
            Spacer()
            
            if entry.trophy != nil {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(trophyColor)
            }
        }
    }
}

// MARK: - Kudos Button

struct KudosButton: View {
    let count: Int
    let isLiked: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .font(.system(size: 14, weight: .semibold))
                Text("\(count) Kudos")
                    .font(.system(size: 14, weight: .semibold))
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(Color.clear)
        .foregroundColor(
            isLiked ? Color.communityKudosRed : Color.zoomieSecondaryText
        )
        .buttonStyle(.plain)
    }
}

// MARK: - Colors for Community

extension Color {
    static let communityKudosOrange = Color(red: 245/255, green: 154/255, blue: 79/255)
    static let communityKudosRed    = Color(red: 231/255, green: 76/255,  blue: 60/255)
    static let leaderboardGold      = Color(red: 244/255, green: 179/255, blue: 52/255)
    static let leaderboardSilver    = Color(red: 180/255, green: 188/255, blue: 198/255)
    static let leaderboardBronze    = Color(red: 205/255, green: 127/255, blue: 50/255)
}

// MARK: - Preview

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
            .environmentObject(PetProfile())
    }
}
