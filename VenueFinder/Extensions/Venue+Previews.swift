//
//  Venue+Previews.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

extension Array where Element == Venue {
    static var previews: [Venue] {
        let restaurant = Category(
            id: "4d4b7105d754a06374d81259",
            name: "Restaurant",
            icon: Icon(prefix: "https://ss3.4sqi.net/img/categories_v2/food/default_", suffix: ".png")
        )
        let bar = Category(
            id: "4bf58dd8d48988d116941735",
            name: "Bar",
            icon: Icon(prefix: "https://ss3.4sqi.net/img/categories_v2/nightlife/pub_", suffix: ".png")
        )
        return [
            Venue(name: "The Golden Fork", rating: 4, distance: 1.2, category: restaurant),
            Venue(name: "Brew & Barrel", rating: 5, distance: 0.8, category: bar),
            Venue(name: "Zen Spa & Wellness", rating: 4, distance: 3.5, category: restaurant),
        ]
    }
}
