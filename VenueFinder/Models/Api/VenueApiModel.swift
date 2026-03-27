//
//  Result.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 22.03.2026.
//

struct VenueApiModel: ApiModel, Identifiable {
    var id: String
    var name: String?
    var distance: Double?
    var rating: Double?
    var timezone: String?
    var category: CategoryApiModel?
    var location: LocationApiModel?
}
