//
//  Navigator.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

public enum Tab: Codable {
    case venues
    case favorites
}

@Observable // (why do we need this?)
final class Navigator {
    
    var selectedTab: Tab = .venues
    var venuesPath: [Screen] = []
    var favoritesPath: [Screen] = []
    
    // MARK: - Handle deeplinks
    
    func handleDeepLink(_ url: URL) {
        guard let screens = parseURL(url) else { return }
        
        // Select the appropriate tab
        if let first = screens.first {
            switch first {
            case .venues: selectedTab = .venues
            case .favorites: selectedTab = .favorites
            }
        }
        
        // Set the path
        switch selectedTab {
        case .venues:
            venuesPath = screens
        case .favorites:
            favoritesPath = screens
        }
    }
    
    private func parseURL(_ url: URL) -> [Screen]? {
        // Pattern match URL components to Screen cases
        // e.g., "/landmarks/123" -> [.landmarks(.detail(landmark))]
        return []
    }
    
    
    // MARK: - Restore state
    
    struct RestorationState: Codable {
        let selectedTab: Tab
        let venuesPath: [Screen]
        let favoritesPath: [Screen]
    }
    
    func saveState() {
        let state = RestorationState(
            selectedTab: selectedTab,
            venuesPath: venuesPath,
            favoritesPath: favoritesPath
        )
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: "NavigatorState")
        }
    }
    
    func loadState() {
        guard let data = UserDefaults.standard.data(forKey: "NavigatorState"),
              let state = try? JSONDecoder().decode(RestorationState.self, from: data) else {
            return
        }
        selectedTab = state.selectedTab
        venuesPath = state.venuesPath
        favoritesPath = state.favoritesPath
    }
}

