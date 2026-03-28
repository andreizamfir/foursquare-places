//
//  Screen.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

public enum Screen: Codable, Hashable, Identifiable {
    case venues(VenuesScreen)
    case favorites(FavoritesScreen)

    public var id: Self { self }

    public enum VenuesScreen: Codable, Hashable {
        case root
        case detail(Venue)
        case category(Category)
    }

    public enum FavoritesScreen: Codable, Hashable {
        case root
        case detail(Venue)
    }
}
