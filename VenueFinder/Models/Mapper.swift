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
              let location = location?.domainModel,
              let categories = categories,
              let rating = rating,
              let distance = distance else {
            return nil
        }
        
        return Venue(
            id: UUID(uuidString: id) ?? UUID(),
            name: name,
            location: location,
            categories: categories.compactMap { $0.domainModel },
            rating: rating,
            distance: distance
        )
    }
}

extension LocationApiModel {
    var domainModel: Location? {
        guard let address = address,
              let city = city,
              let state = state,
              let country = country,
              let postcode = postcode else {
            return nil
        }
        
        return Location(
            address: address,
            city: city,
            state: state,
            country: country,
            postcode: postcode
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
