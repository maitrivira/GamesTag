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
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(named: "Navy")
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

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let standardApperance = UINavigationBarAppearance()
        standardApperance.backgroundColor = UIColor(named: "Navy")
        standardApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.standardAppearance = standardApperance
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
