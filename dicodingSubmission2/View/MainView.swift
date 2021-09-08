//
//  ContentView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var gameData = GameViewModel()
    @ObservedObject var favorites = Favorites()
    @ObservedObject var profile = Profile()
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
            Search(viewModel: SearchViewModel())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .accentColor(.white)
        .environmentObject(gameData)
        .environmentObject(favorites)
        .environmentObject(profile)
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
