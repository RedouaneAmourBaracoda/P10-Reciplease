//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by Redouane on 24/11/2024.
//

import SwiftUI

@main
struct RecipleaseApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .tabItem {
                        Text(Localizable.searchTabBarItemTitle)
                    }

                Text("")
                    .tabItem {
                        Text(Localizable.favoritesTabBarItemTitle)
                    }
            }
            .onAppear {
                UITabBarItem.appearance().setTitleTextAttributes(
                    [.font: UIFont(name: CustomFonts.body, size: 30.0)!],
                  for: .normal)
                UITabBar.appearance().backgroundColor = .init(CustomColors.main)
                UITabBar.appearance().unselectedItemTintColor = .white
            }
        }
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
