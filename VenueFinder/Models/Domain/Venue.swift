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
    public let location: Location
    public let categories: [Category]
    public let rating: Double
    public let distance: Int

    // Business logic belongs here
    public var displayTitle: String {
        "\(name), \(distance) km away"
    }
}

extension Venue: Cacheable {
    public var cacheId: String { id.uuidString }
    public static var cacheIdentifier: String { "venues" }
}
