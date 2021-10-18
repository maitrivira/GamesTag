//
//  ContentView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var gameData = GameViewModel()
    @ObservedObject var profile = ProfileViewModel()
    @ObservedObject var favoritesViewModel = FavoriteViewModel()
    @ObservedObject var gameDetail = GameDetailViewModel()
    @ObservedObject var searchViewModel = SearchViewModel()
    let coloredNavAppearance = UINavigationBarAppearance()
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(named: "Navy")
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.init(named: "Navy")
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    var body: some View {
        TabView {
            GamesList()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
            Search()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .accentColor(.white)
        .environmentObject(gameData)
        .environmentObject(profile)
        .environmentObject(favoritesViewModel)
        .environmentObject(gameDetail)
        .environmentObject(searchViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
