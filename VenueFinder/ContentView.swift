//
//  ContentView.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(Navigator.self) private var navigator
    
    var body: some View {
        @Bindable var navigator = navigator
        
        TabView(selection: $navigator.selectedTab) {
            NavigationStack(path: $navigator.venuesPath) {
                VenuesListView()
                    .screenDestination(path: $navigator.venuesPath)
            }
            .tabItem { Label("Venues", systemImage: "map") }
            .tag(Tab.venues)
            
            NavigationStack(path: $navigator.favoritesPath) {
                FavoritesView()
                    .screenDestination(path: $navigator.favoritesPath)
            }
            .tabItem { Label("Favorites", systemImage: "heart") }
            .tag(Tab.favorites)
        }
        // MARK: - Restore state
        .onAppear {
            navigator.loadState()
        }.onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willResignActiveNotification
        )) { _ in
            navigator.saveState()
        }
    }
}

#Preview {
    ContentView()
}
