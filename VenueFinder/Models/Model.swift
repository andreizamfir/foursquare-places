//
//  Model.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

// MARK: - Models

public struct Venue: Codable, Equatable, Hashable, Identifiable {
    public let id = UUID()
    var name: String
    var rating: Int
    var distance: Double
    var category: Category
    
    enum CodingKeys: String, CodingKey {
        case name, rating, distance, category
    }
    
    init(name: String, rating: Int, distance: Double, category: Category) {
        self.name = name
        self.rating = rating
        self.distance = distance
        self.category = category
    }
}

struct VenuesResponse: Codable {
    let venues: [Venue]
}

// MARK: - Views

struct CategoryView: View {
    let category: Category
    var path: Binding<[Screen]>?
    
    var body: some View {
        Text("Category View")
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("Favorites View")
    }
}
