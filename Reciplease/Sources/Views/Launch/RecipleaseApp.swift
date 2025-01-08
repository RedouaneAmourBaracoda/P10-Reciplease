//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

// MARK: - TODO:

// Unit tests CoreDataStack et le Repository
// Rajouter dans la .gitignore le DSSTORE
// Terminer l'internationalisation
// Ajouter la politque de cache avec KingFisher
// Ajouter des accessibilité label pour voicover

// Modifier l'apparance des recettes (distorsions des images avec clip shape + ecriture avec background).

@main
struct RecipleaseApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .tabItem { Text(Localizable.searchTabBarItemTitle) }

                FavoriteRecipesListView()
                    .tabItem { Text(Localizable.favoritesTabBarItemTitle) }
            }
            .onAppear { configureAppearance() }
        }
    }

    private func configureAppearance() {
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont(name: CustomFonts.body, size: 30.0)!],
          for: .normal)
        UITabBar.appearance().backgroundColor = .init(CustomColors.main)
        UITabBar.appearance().unselectedItemTintColor = .white
    }
}

private extension Localizable {
    static let searchTabBarItemTitle = NSLocalizedString(
        "tabs.search.title",
        comment: ""
    )

    static let favoritesTabBarItemTitle = NSLocalizedString(
        "tabs.favorites.title",
        comment: ""
    )
}
