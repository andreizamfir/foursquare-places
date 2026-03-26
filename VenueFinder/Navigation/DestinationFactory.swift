//
//  Destination.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

// TODO: Rename to Navigator? Current Navigator only handles deeplinks

public struct DestinationFactory {
    
    @ViewBuilder
    public static func content(
        for screen: Screen,
        path: Binding<[Screen]>? = nil
    ) -> some View {
        switch screen {
        case .venues(let screen):
            VenuesDestination(screen: screen, path: path)
        case .favorites(let screen):
            FavoritesDestination(screen: screen, path: path)
        }
    }
    
}

struct VenuesDestination: View {
    let screen: Screen.VenuesScreen
    var path: Binding<[Screen]>?

    var body: some View {
        switch screen {
        case .root:
            VenuesListView()
        case .detail(let venue):
            VenueDetailView(venue: venue)
        case .category(let category):
            CategoryView(category: category, path: path)
        }
    }
}

struct FavoritesDestination: View {
    let screen: Screen.FavoritesScreen
    var path: Binding<[Screen]>?

    var body: some View {
        switch screen {
        case .root:
            VenuesListView()
        case .detail(let venue):
            VenueDetailView(venue: venue)
        }
    }
}
