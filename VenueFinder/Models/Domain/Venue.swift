//
//  Venues.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 26.03.2026.
//
import Foundation

public struct Venue: DomainModel, Identifiable {
    public let id: UUID
    public let name: String
    public let distance: Double
    public let rating: Double
    public let timezone: String
    public let location: Location
    public let category: Category

    // Business logic belongs here
    public var displayTitle: String {
        "\(name), \(category.name), \(distance) km away"
    }
}

struct VenuesResponse: Codable {
    let venues: [Venue]
}
