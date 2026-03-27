//
//  Venue+Previews.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import Foundation

extension Array where Element == Venue {
    static var previews: [Venue] {
        let restaurant = Category(
            id: UUID(uuidString: "4d4b7105d754a06374d81259") ?? UUID(),
            name: "Restaurant",
            icon: Icon(prefix: "https://ss3.4sqi.net/img/categories_v2/food/default_", suffix: ".png")
        )
        let bar = Category(
            id: UUID(uuidString: "4bf58dd8d48988d116941735") ?? UUID(),
            name: "Bar",
            icon: Icon(prefix: "https://ss3.4sqi.net/img/categories_v2/nightlife/pub_", suffix: ".png")
        )
        return [
            Venue(id: UUID(), name: "Brew & Barrel", distance: 0.8, rating: 5, timezone: "UTC+2", location: .preview, category: bar),
            Venue(id: UUID(), name: "Zen Spa & Wellness", distance: 3.5, rating: 4, timezone: "UTC+2", location: .preview, category: restaurant),
            Venue(id: UUID(), name: "The Golden Fork", distance: 1.2, rating: 4, timezone: "UTC+2", location: .preview, category: restaurant)
        ]
    }
}

extension Venue {
    static var preview: Venue {
        Venue(
            id: UUID(),
            name: "Sample Venue",
            distance: 1.5,
            rating: 4.5,
            timezone: "UTC",
            location: .preview,
            category: .preview
        )
    }
}

extension Location {
    static var preview: Location {
        Location(
            address: "123 Main St",
            country: "USA",
            locality: "San Francisco",
            postcode: "94105",
            region: "CA"
        )
    }
}

extension Category {
    static var preview: Category {
        Category(
            id: UUID(),
            name: "Restaurant",
            icon: Icon.preview
        )
    }
}

extension Icon {
    static var preview: Icon {
        Icon(prefix: "https://example.com/", suffix: ".png")
    }
}
