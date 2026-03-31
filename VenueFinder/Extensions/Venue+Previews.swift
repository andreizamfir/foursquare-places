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
            Venue(id: UUID(uuidString: "venue1")!, name: "Brew & Barrel", location: .preview, categories: [bar], rating: 5, distance: 800),
            Venue(id: UUID(uuidString: "venue2")!, name: "Zen Spa & Wellness", location: .preview, categories: [restaurant], rating: 4, distance: 3500),
            Venue(id: UUID(uuidString: "venue3")!, name: "The Golden Fork", location: .preview, categories: [restaurant], rating: 4, distance: 1200)
        ]
    }
}

extension Venue {
    static var preview: Venue {
        Venue(
            id: UUID(uuidString: "venue1")!,
            name: "Sample Venue",
            location: .preview,
            categories: [.preview],
            rating: 4.5,
            distance: 1500
        )
    }
}

extension Location {
    static var preview: Location {
        Location(
            address: "123 Main St",
            city: "San Francisco",
            state: "CA",
            country: "USA",
            postcode: "94105"
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
