//
//  ContentView.swift
//  dicodingSubmission2
//
//  Created by Maitri Vira on 17/08/21.
//

import SwiftUI

struct MainView: View {
    @StateObject var gameData = GameViewModel()
    @ObservedObject var favorites = Favorites()
    var body: some View {
        TabView {
            GamesList()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
                .environmentObject(gameData)
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
            About()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(favorites)
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let standardApperance = UINavigationBarAppearance()
        standardApperance.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.50, alpha: 1.00)
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
