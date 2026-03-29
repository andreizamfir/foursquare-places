//
//  Service.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 28.03.2026.
//

import Observation

@Observable
final class Services {
    let venuesStore: VenuesStore

    // Add more stores here as the app grows
    // let favoritesStore: FavoritesStore

    init(venuesStore: VenuesStore) {
        self.venuesStore = venuesStore
    }
}

extension Services {

    static var live: Services {
        Services(venuesStore: VenuesStore(service: .live()))
    }

    static var mock: Services {
        Services(venuesStore: VenuesStore(service: .mock()))
    }

    static var preview: Services {
        Services(venuesStore: VenuesStore(service: .preview()))
    }
}
