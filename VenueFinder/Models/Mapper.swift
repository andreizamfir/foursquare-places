//
//  Mapping.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 26.03.2026.
//
import SwiftUI

extension VenueApiModel {
    var domainModel: Venue? {
        // Validate required fields
        guard let name = name?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty,
              let distance = distance,
              let rating = rating,
              let timezone = timezone,
              let location = location?.domainModel,
              let category = category?.domainModel else {
            return nil
        }
        
        return Venue(
            id: UUID(uuidString: id) ?? UUID(),
            name: name,
            distance: distance,
            rating: rating,
            timezone: timezone,
            location: location,
            category: category
        )
    }
}

extension LocationApiModel {
    var domainModel: Location? {
        guard let address = address,
              let country = country,
              let locality = locality,
              let postcode = postcode,
              let region = region else {
            return nil
        }
        
        return Location(
            address: address,
            country: country,
            locality: locality,
            postcode: postcode,
            region: region
        )
    }
}

extension CategoryApiModel {
    var domainModel: Category? {
        guard let name = name,
              let icon = icon?.domainModel else {
            return nil
        }
        
        return Category(
            id: UUID(uuidString: id) ?? UUID(),
            name: name,
            icon: icon
        )
    }
}

extension IconApiModel {
    var domainModel: Icon? {
        guard let prefix = self.prefix,
              let suffix = self.suffix else {
            return nil
        }
        
        return Icon(prefix: prefix, suffix: suffix)
    }
}
