//
//  Location.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 22.03.2026.
//

struct LocationApiModel: ApiModel {
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var postcode: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case state
        case country
        case postcode = "postal_code"
    }
}
