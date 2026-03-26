//
//  ContentView.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .venues
    @State private var venuesPath: [Screen] = []
    @State private var favoritesPath: [Screen] = []
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $venuesPath) {
                VenuesListView()
                    .screenDestination(path: $venuesPath)
            }
            .tabItem { Label("Venues", systemImage: "map") }
            .tag(Tab.venues)
            
            NavigationStack(path: $favoritesPath) {
                FavoritesView()
                    .screenDestination(path: $favoritesPath)
            }
            .tabItem { Label("Favorites", systemImage: "heart") }
            .tag(Tab.favorites)
        }
    }
}

#Preview {
    ContentView()
}
