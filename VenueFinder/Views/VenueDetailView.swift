//
//  VenueDetailView.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI


struct VenueDetailView: View {
    let venue: Venue
    
    init(venue: Venue) {
        self.venue = venue
    }
    
    var body: some View {
        Text(venue.name)
            .font(.largeTitle)
            .foregroundStyle(.foreground)
        
        ForEach(venue.categories) { category in
            Text(category.name)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
}
