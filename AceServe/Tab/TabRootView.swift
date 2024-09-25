////
////  TabRootView.swift
////  AceServe
////
////  Created by D K on 22.09.2024.
////
//
import SwiftUI

struct TabRootView: View {
    
    @State private var isTabBarShown = true
    @State private var selectedTab = Tab.home
    @EnvironmentObject var authViewModel: AuthViewModel
    @Namespace var namespace
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $selectedTab) {
                    
                    MainView()
                        .tag(Tab.home)
                    
                    LoyaltyView()
                        .tag(Tab.loyalty)
                    
                    NewsView()
                        .tag(Tab.news)
                    
                    
                    ProfileView()
                        .environmentObject(authViewModel)
                        .tag(Tab.settings)
                }
                
                if isTabBarShown {
                    
                    HStack(spacing: 0) {
                        TabButton(tab: .home, selectedTab: $selectedTab, namespace: namespace)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(tab: .loyalty, selectedTab: $selectedTab, namespace: namespace)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(tab: .news, selectedTab: $selectedTab, namespace: namespace)
                        
                        Spacer(minLength: 0)
                        
                        TabButton(tab: .settings, selectedTab: $selectedTab, namespace: namespace)
                    }
                    .frame(width: displaySize().width - 55, height: 80)
                    .padding(.horizontal)
                    .background {
                        Rectangle()
                            .fill(Color.darkBlue)
                            .shadow(color: .lightPurple.opacity(0.2), radius: 20, x: 0, y: 20)
                            .frame(width: displaySize().width - 15, height: 75)
                            .cornerRadius(24)
                    }
                }
            }
        }
    }
}

#Preview {
    TabRootView()
}


private struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation {
                selectedTab = tab
                
            }
        } label: {
            ZStack {
                if isSelected {
                    Circle()
                        .frame(height: 70)
                        .foregroundColor(.darkBlue)
                        .shadow(radius: 10)
                        .background {
                            Circle()
                                .stroke(lineWidth: 15)
                                .foregroundColor(.lightPurple.opacity(0.7))
                        }
                        .offset(y: -25)
                        .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                        .animation(.spring(), value: selectedTab)
                }
                
                Image(systemName: tab.icon)
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                    .scaleEffect(isSelected ? 1 : 0.8)
                    .offset(y: isSelected ? -25 : 0)
                    .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var isSelected: Bool {
        selectedTab == tab
    }
}



enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, loyalty, news, settings
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .loyalty:
            return "heart.rectangle.fill"
        case .news:
            return "newspaper.fill"
        case .settings:
            return "person.fill"
        }
    }
}




