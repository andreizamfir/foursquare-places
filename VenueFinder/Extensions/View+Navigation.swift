//
//  View-Navigation.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

extension View {
    func screenDestination(path: Binding<[Screen]>) -> some View {
        self.navigationDestination(for: Screen.self) { screen in
            DestinationFactory.content(for: screen, path: path)
        }
    }
}

extension NavigationLink where Destination == Never {
    init(screen: Screen, @ViewBuilder label: () -> Label) {
        self.init(value: screen, label: label)
    }
}
