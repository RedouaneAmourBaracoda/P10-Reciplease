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
                        Text("Search")
                    }

                Text("")
                    .tabItem {
                        Text("Favorite")
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
