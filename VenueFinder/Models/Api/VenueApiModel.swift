//
//  Result.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 22.03.2026.
//

struct VenuesApiResponse: ApiModel {
    let venues: [VenueApiModel]
    
    enum CodingKeys: String, CodingKey {
        case venues = "results"
    }
}

struct VenueApiResult: ApiModel, Identifiable {
    let id: String?
    let venue: VenueApiModel

    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case venue = "place"
    }
}

struct VenueApiModel: ApiModel, Identifiable {
    var id: String
    var name: String?
    var location: LocationApiModel?
    var categories: [CategoryApiModel]?
    var rating: Double?
    var distance: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case name
        case location
        case categories
        case rating
        case distance
    }
}
