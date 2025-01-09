//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

// MARK: - TODO:

// Pour le green coding: parler du cache pour les images, et qu'on limite les appels réseaux
// Pour la présentation: parler de deux fichiers :
// 1. le privacy manifest dans xcode pour l'utilisation d'api apple comme USER DEFAULT CORELOCATION etc.
// 2. le formulaire apple (Apple privacy form developer) a preparer avant soumission avec des questions.
// Être capable d'expliquer comme preparer la soumission sur l'app store avec : les deux fichiers cités plus haut, le bundle id de l'app, le code signing (un certificat et provisioning profile).
// Ajouter la politque de cache avec KingFisher -> Ne pas tester le cache avec kingsfisher
// Ajouter des accessibilité label pour voicover

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
